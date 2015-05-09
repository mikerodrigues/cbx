require_relative './spec_helper.rb'

cbe = CBX.new(ENV['SANDBOX_API_KEY'], ENV['SANDBOX_API_SECRET'], ENV['SANDBOX_API_PASSPHRASE'])

describe 'Trading' do
  it 'must be authenticated' do
    expect(cbe.authenticated?).to eq(true)
  end

  describe '#accounts' do
    it 'can retrieve a list of accounts' do
      accounts = cbe.accounts
      expect(accounts.first.key?('id'))
      expect(accounts.first.key?('currency'))
      expect(accounts.first.key?('balance'))
      expect(accounts.first.key?('hold'))
      expect(accounts.first.key?('available'))
      expect(accounts.first.key?('profile_id'))
    end

    it 'can retreive an account by an id' do
      account = cbe.accounts(cbe.accounts.first.fetch('id'))
      expect(accounts.key?('id'))
      expect(accounts.key?('currency'))
      expect(accounts.key?('balance'))
      expect(accounts.key?('hold'))
      expect(accounts.key?('available'))
      expect(accounts.key?('profile_id'))
    end
  end

  describe '#ledger' do

    # I should place some orders and then test those, there's no gaurantee a
    # given sandbox account will have any activity.
    it 'gets a list of account activities' do
      skip 'Need to create some test orders and an account first'
      ledger = cbe.ledger(account.fetch('id'))
      expect(ledger.first.key?('id'))
      expect(ledger.first.key?('created_at'))
      expect(ledger.first.key?('amount'))
      expect(ledger.first.key?('balance'))
      expect(ledger.first.key?('type'))
      expect(ledger.first.key?('details'))
    end
    it 'supports pagination' do
      skip 'need to create a bunch of transactions first'
    end
  end
end




