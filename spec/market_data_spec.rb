require_relative './spec_helper.rb'

cbe = CBX.new

describe 'MarketData' do
  describe '#products' do
    it 'can get a array of available trading currencies' do
      expect(cbe.products.code).to eq(200)
    end
  end

  describe '#book' do
    it 'can get a level 1 orderbook' do
      expect(cbe.book.code).to eq(200)
    end

    it 'can get a level 2 orderbook' do
      expect(cbe.book({ level: 2 }).code).to eq(200)
    end

    it 'can get a level 3 orderbook' do
      expect(cbe.book({ level: 3 }).code).to eq(200)
    end
  end

  describe '#ticker' do
    it 'can get information about the last trade' do
      expect(cbe.ticker.code).to eq(200)
    end
  end

  describe '#trades' do
    it 'get list of trades' do
      expect(cbe.trades.code).to eq(200)
    end
  end

  describe '#candles' do

    it 'gets list of historical trades' do
      skip 'coinbase is having problems with this endpoint'
      expect(cbe.candles.code).to eq(200)
    end

    it 'accepts :start, :end, and :granularity params' do
      skip 'coinbase is having problems with this endpoint'
      start = Time.now
      _end = Time.now + 120
      granularity = 20
      expect(cbe.candles({ start: start, end: _end, granularity: granularity }).code).to eq(200)
    end
  end

  describe '#stats' do
    it 'gets 24 hour stats' do
      expect(cbe.stats.code).to eq(200)
    end

  end

  describe '#currencies' do
    it 'gets a list of currencies' do
      expect(cbe.currencies.code).to eq(200)
    end

  end

  describe '#time' do
    it 'gets the current time' do
      expect(cbe.time.code).to eq(200)
    end
  end
end
