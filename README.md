This is a fork of a project originally authored by Daniel Silver
(https://github.com/dan-silver/coinbase_exchange)

The fork features convenience methods for all endpoint functionality and
allows for unauthenticated access to Market Data and the WebSocket feed.

# Coinbase Exchange Ruby Client
The library wraps the http request and message signing.  Create an account at https://exchange.coinbase.com to get started.

### NOTE - As a launch promo, there are [no Coinbase Exchange trading fees](http://blog.coinbase.com/post/109202118547/coinbase-launches-first-regulated-bitcoin-exchange) through the end of March.

## Installation

Or, include this in your gemfile:
```gem 'coinbase_exchange', :git=> 'git://github.com/mikerodrigues/coinbase_exchange.git'```

## Example
```ruby
require "coinbase_exchange"

# For unauthenticated access:
cbe = CoinbaseExchange.new

# For authenticated access:
cbe = CoinbaseExchange.new API_KEY, API_SECRET, API_PASSPHRASE


# List accounts
cbe.accounts
# => [{"id"=>"000ea663...", "currency"=>"USD", "balance"=>"90.0000114750000000", "hold"=>"0.0000000000000000", "available"=>"0.9000114750000000", "profile_id"=>"4409df27..."}, {"id"=>"8bfe", "currency"=>"BTC", "balance"=>"9.4426882700000000", "hold"=>"0.0000000000000000", "available"=>"5.4426882700000000", "profile_id"=>"a8f2d8..."}] 

# List orders
cbe.orders

# List orders with pagination
cbe.order({'limit'=>5, after=>1})

# Get specific order by order_id
cbe.order('4488340..')

# Place an order (size, price, side)
cbe.place_order("0.01", "250.000", "buy")
cbe.place_order("0.02", "265.000", "sell")

# Cancel an order by order_id
cbe.cancel_order('488224434...')

# Product tickers (defaults to 'BTC-USD')
cbe.ticker("BTC-USD")
# => {"trade_id"=>125681, "price"=>"226.20000000", "size"=>"0.01570000", "time"=>"2015-02-08T04:46:17.352746Z"}

# Product fills
cbe.fills

# Get a live feed from the websocket. You'll need to create a lambda to pass
messages to as they are received:
feed = CoinbaseExchange::Feed.new(->{|msg| puts msg.fetch('type')})a

# Close the feed if needed
feed.close


```

Block syntax is fully supported

```ruby

cbe.get('accounts') do |response|
  puts response
end

cbe.post('orders', {
    "size" => 1.01,
    "price" => 1.100,
    "side" => "buy",
    "product_id" => "BTC-USD"
}) do |response|
  puts response
end

```

Use at your own risk. I assume no liability for gains or losses you incur while using this gem.
