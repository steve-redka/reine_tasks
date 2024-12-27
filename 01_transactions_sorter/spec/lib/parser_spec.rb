require 'rspec'
require 'parser'

RSpec.describe Parser do
  describe '.parse_line' do
    let(:line) { "2023-09-03T12:45:00Z,txn12345,user987,500.25\n" }

    it 'parses a valid line into a Transaction object' do
      transaction = Parser.parse_line(line)

      expect(transaction).to be_a(Transaction)
      expect(transaction.timestamp).to eq('2023-09-03T12:45:00Z')
      expect(transaction.transaction_id).to eq('txn12345')
      expect(transaction.user_id).to eq('user987')
      expect(transaction.amount).to eq(500.25)
    end
  end
end
