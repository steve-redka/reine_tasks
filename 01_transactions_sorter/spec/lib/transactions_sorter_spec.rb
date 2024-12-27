require 'rspec'
require 'faker'
require 'transactions_sorter'

RSpec.describe 'TransactionsSorter' do
  let(:test_input_file) { 'test_input.txt' }
  let(:output_file) { 'test_output.txt' }

  after do
    File.delete(test_input_file) if File.exist?(test_input_file)
    File.delete(output_file) if File.exist?(output_file)
  end

  def generate_test_file(file_path, size_in_kb)
    File.open(file_path, 'w') do |file|
      while file.size < size_in_kb * 1024
        timestamp = Faker::Time.backward(days: 30).iso8601
        transaction_id = Faker::Alphanumeric.alphanumeric(number: 10)
        user_id = Faker::Internet.username
        amount = Faker::Number.decimal(l_digits: 3, r_digits: 2)
        file.puts("#{timestamp},#{transaction_id},#{user_id},#{amount}")
      end
    end
  end

  it 'sorts transactions by amount in descending order' do
    File.open(test_input_file, 'w') do |file|
      file.puts '2023-09-03T12:45:00Z,txn1,user1,200.50'
      file.puts '2023-09-03T12:45:01Z,txn2,user2,500.00'
      file.puts '2023-09-03T12:45:02Z,txn3,user3,300.25'
    end

    TransactionsSorter.sort(test_input_file, output_file)
    result = File.readlines(output_file).map(&:strip)

    expect(result).to eq([
      '2023-09-03T12:45:01Z,txn2,user2,500.0',
      '2023-09-03T12:45:02Z,txn3,user3,300.25',
      '2023-09-03T12:45:00Z,txn1,user1,200.5'
    ])
  end

  it 'sorts a randomly generated file of at least 10 KB' do
    generate_test_file(test_input_file, 10)

    TransactionsSorter.sort(test_input_file, output_file)
    result = File.readlines(output_file).map { |line| Parser.parse_line(line) }

    # Validate the order of the sorted transactions
    expect(result.each_cons(2).all? { |a, b| a.amount >= b.amount }).to be true
  end
end
