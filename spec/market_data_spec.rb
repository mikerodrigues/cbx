require_relative './spec_helper.rb'

cbe = CBX.new

describe 'MarketData' do
  describe '#products' do
    it 'can get a array of available trading currencies starting with BTC-USD' do
      expect(cbe.products.first.fetch('id')).to eq('BTC-USD')
    end
  end

  describe '#book' do
    book = cbe.book
    it 'can get a level 1 orderbook with the best ask and bid' do
      book = cbe.book
      expect(book.fetch('bids').count).to eq(1)
    end

    it 'can get a level 2 orderbook with the 50 best asks and bids' do
      book = cbe.book({ level: 2 })
      expect(book.fetch('asks').count).to be > 1
      expect(book.fetch('bids').count).to be > 1
    end

    it 'can get a level 3 orderbook snapshot with unaggregated bids' do
      book = cbe.book({ level: 3 })
      expect(book.fetch('bids').first.fetch(2)).to_not match(/^\d+$/)
      expect(book.fetch('asks').first.fetch(2)).to_not match(/^\d+$/)
    end
  end

  describe '#ticker' do
    it 'can get information about the last trade' do
      @ticker = cbe.ticker
      expect(@ticker.fetch('trade_id').class).to eq(Fixnum)
      expect(@ticker.key?('price')).to eq(true)
      expect(@ticker.key?('size')).to eq(true)
    end
  end

  describe '#trades' do
    it 'get list of trades with time, trade_id, price, size, and side' do
      @trades = cbe.trades
      expect(@trades.first.key?('time')).to eq(true)
      expect(@trades.first.key?('trade_id')).to eq(true)
      expect(@trades.first.key?('price')).to eq(true)
      expect(@trades.first.key?('size')).to eq(true)
      expect(@trades.first.key?('side')).to eq(true)
    end
  end

  describe '#candles' do
    it 'gets list of historical trades, accepts :start, :end, and :granularity params' do
      @candles = cbe.candles
      expect(@candles.class).to eq(Array)
      expect(@candles.first.class).to eq(Array)
    end

    it 'accepts :start, :end, and :granularity params' do
      start = Time.now
      _end = Time.now + 120
      granularity = 20
      @candles = cbe.candles({ start: start, end: _end, granularity: granularity })
      expect(Time.at(@candles.first.first)).to be >= start
      expect(Time.at(@candles.last.first)).to be <= _end
    end
  end

  describe '#stats' do
    it 'gets 24 hour stats' do
      @stats = cbe.stats
      expect(@stats.key?('open')).to eq(true)
      expect(@stats.key?('high')).to eq(true)
      expect(@stats.key?('low')).to eq(true)
      expect(@stats.key?('volume')).to eq(true)
    end

  end

  describe '#currencies' do
    it 'gets a list of currencies' do
      @currencies = cbe.currencies
      expect(@currencies.first.fetch('id')).to eq('USD')
      expect(@currencies.first.fetch('name')).to eq('United States Dollar')
      expect(@currencies.first.fetch('min_size')).to eq('0.01000000')
    end

  end

  describe '#time' do
    it 'gets the current time' do
      @time = cbe.time
      expect(@time.key?('iso')).to eq(true)
      expect(@time.key?('epoch')).to eq(true)
    end
  end
end
