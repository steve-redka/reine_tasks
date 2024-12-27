require 'transaction'

class Parser
  def self.parse_line(line)
    timestamp, transaction_id, user_id, amount = line.strip.split(',')
    Transaction.new(timestamp, transaction_id, user_id, amount)
  end
end
