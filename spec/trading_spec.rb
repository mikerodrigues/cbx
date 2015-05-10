require_relative './spec_helper.rb'


describe 'Trading' do
  if ENV['SANDBOX_API_KEY'] && ENV['SANDBOX_API_SECRET'] && ENV['SANDBOX_API_PASSPHRASE']
    cbe = CBX.new(ENV['SANDBOX_API_KEY'], ENV['SANDBOX_API_SECRET'], ENV['SANDBOX_API_PASSPHRASE'])
  else
    skip 'No credentials given.'
  end

  it 'must be authenticated' do
    expect(cbe.authenticated?).to eq(true)
  end

  describe '#accounts' do
    it 'can retrieve a list of accounts' do
      expect(cbe.accounts.code).to eq(200)
    end
  end

  describe '#account' do
    it 'can retreive an account by an id' do
      accounts = cbe.accounts
      expect(accounts.cbe.accounts(accounts.body.first.fetch('id'))).to eq(200)
    end
  end

  describe '#ledger' do
    # I should place some orders and then test those, there's no gaurantee a
    # given sandbox account will have any activity.
    it 'gets a list of account activities' do
      skip
      expect(cbe.ledger).to eq(200)
    end

    it 'supports pagination' do
      skip
    end
  end

  describe '#holds' do
  end

  describe '#orders' do
  end

  describe '#order' do
  end

  describe '#place_order' do
  end

  describe '#cancel_order' do
  end

  describe '#deposit' do
  end

  describe '#withdraw' do
  end

  describe '#fills' do
  end

  describe '#create_report' do
  end

  describe '#report' do
  end

end





