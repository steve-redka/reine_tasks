require 'parser'
require 'tempfile'

class TransactionsSorter
  def self.sort(input_file, output_file, chunk_size = 1000)
    chunks = split_and_sort_chunks(input_file, chunk_size)
    merge_chunks(chunks, output_file)
  end

  def self.split_and_sort_chunks(input_file, chunk_size)
    chunks = []
    current_chunk = []
    File.foreach(input_file) do |line|
      current_chunk << Parser.parse_line(line)
      if current_chunk.size >= chunk_size
        chunks << write_chunk_to_temp_file(current_chunk)
        current_chunk = []
      end
    end
    chunks << write_chunk_to_temp_file(current_chunk) unless current_chunk.empty?
    chunks
  end

  def self.write_chunk_to_temp_file(chunk)
    chunk.sort_by! { |txn| -txn.amount }
    temp_file = Tempfile.new('chunk')
    chunk.each { |txn| temp_file.puts(txn.to_s) }
    temp_file.close
    temp_file
  end

  def self.merge_chunks(chunks, output_file)
    sorted_files = chunks.map { |file| File.open(file.path, 'r') }
    File.open(output_file, 'w') do |output|
      lines = sorted_files.map(&:gets)
      until lines.all?(&:nil?)
        max_index = lines.each_with_index.max_by { |line, _| line ? Parser.parse_line(line).amount : -Float::INFINITY }[1]
        output.puts lines[max_index]
        lines[max_index] = sorted_files[max_index].gets
      end
    end
    sorted_files.each(&:close)
    chunks.each(&:unlink)
  end
end
