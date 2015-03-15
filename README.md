This is a fork of a project originally authored by Daniel Silver
(https://github.com/dan-silver/cbx)

The fork features convenience methods for all endpoint functionality and
allows for unauthenticated access to Market Data and the WebSocket feed.

# Ruby wrapper for the Coinbase Exchange API
The library wraps the http request and message signing and provides convenience
methods for all API functionality.

Create an account at https://exchange.coinbase.com to get started.

### NOTE - As a launch promo, there are [no Coinbase Exchange trading fees](http://blog.coinbase.com/post/109202118547/coinbase-launches-first-regulated-bitcoin-exchange) through the end of March.

## Installation

Include this in your gemfile:

```gem 'cbx', :git=> 'git://github.com/mikerodrigues/cbx.git'```

## Example
```ruby
require "cbx"

# For unauthenticated access:
cbe = CBX.new

# List products
cbe.products
=> [{"id"=>"BTC-USD", "base_currency"=>"BTC", "quote_currency"=>"USD", "base_min_size"=>0.01, "base_max_size"=>10000, "quote_increment"=>0.01, "display_name"=>"BTC/USD"}]

# Get product order book at level 1, 2, or 3, (Defaults to level: 1, product_id "BTC-USD")
cbe.book(1, 'BTC-USD')
=> {"sequence"=>29349454, "bids"=>[["285.22000000", "0.34800000", 3]], "asks"=>[["285.33000000", "0.28930000", 4]]}

# Product tickers (defaults to 'BTC-USD')
cbe.ticker("BTC-USD")
=> {"trade_id"=>125681, "price"=>"226.20000000", "size"=>"0.01570000", "time"=>"2015-02-08T04:46:17.352746Z"}

# Product trades (defaults to 'BTC-USD')
cbe.trades('BTC-USD')
=> [{"time"=>"2015-03-15 04:43:48.7943+00", "trade_id"=>774500, "price"=>"285.44000000", "size"=>"0.01000000", "side"=>"sell"}, 
    {"time"=>"2015-03-15 04:42:54.432661+00", "trade_id"=>774499, "price"=>"285.47000000", "size"=>"0.05340000", "side"=>"sell"},
    {"time"=>"2015-03-15 04:42:54.432306+00", "trade_id"=>774498, "price"=>"285.45000000", "size"=>"0.09100000", "side"=>"sell"}]


# For authenticated access:
cbe = CBX.new API_KEY, API_SECRET, API_PASSPHRASE

# List accounts
cbe.accounts
=> [{"id"=>"000ea663...", "currency"=>"USD", "balance"=>"90.0000114750000000", "hold"=>"0.0000000000000000", "available"=>"0.9000114750000000", "profile_id"=>"4409df27..."}, {"id"=>"8bfe", "currency"=>"BTC", "balance"=>"9.4426882700000000", "hold"=>"0.0000000000000000", "available"=>"5.4426882700000000", "profile_id"=>"a8f2d8..."}] 

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

# Product fills
cbe.fills

# Get a live feed from the websocket. You'll need to create a lambda to pass
messages to as they are received:
feed = CBX::Feed.new(->{|msg| puts msg.fetch('type')})

# Close the feed if needed
feed.close


```

Block syntax is fully supported

```ruby

cbe.accounts do |response|
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
