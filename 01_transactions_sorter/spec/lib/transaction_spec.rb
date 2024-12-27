require 'rspec'
require 'transaction'

RSpec.describe Transaction do
  let(:timestamp) { '2023-09-03T12:45:00Z' }
  let(:transaction_id) { 'txn12345' }
  let(:user_id) { 'user987' }
  let(:amount) { '500.25' }

  describe '#initialize' do
    it 'initializes.' do
      transaction = Transaction.new(timestamp, transaction_id, user_id, amount)

      expect(transaction.timestamp).to eq(timestamp)
      expect(transaction.transaction_id).to eq(transaction_id)
      expect(transaction.user_id).to eq(user_id)
      expect(transaction.amount).to eq(500.25) # amount should be converted to float
    end
  end

  describe '#to_s' do
    it 'returns the correct string representation of the transaction' do
      transaction = Transaction.new(timestamp, transaction_id, user_id, amount)
      expected_string = "#{timestamp},#{transaction_id},#{user_id},500.25"

      expect(transaction.to_s).to eq(expected_string)
    end
  end
end
