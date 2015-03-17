require 'unirest'
require "base64"
require 'openssl'
require 'json'
require 'websocket-client-simple'
require 'cbx/feed'
require 'cbx/pagination'
require 'cbx/trading'
require 'cbx/market_data'
require 'cbx/cbx_signature_maker'
require 'cbx/version'

class CBX
  include MarketData
  attr_reader :authenticated

  API_URL = 'https://api.exchange.coinbase.com/'

  def initialize(key=nil, secret=nil, passphrase=nil)
    if key && secret && passphrase
      @key = key
      @secret = secret
      @passphrase = passphrase
      @coinbaseExchange = CBXSignatureMaker.new(key, secret, passphrase)
      @authenticated = true
      extend Trading
    else 
      @authenticated = false
    end
  end

  def request(method, uri, json=nil)
    params = json.to_json if json
    if authenticated
      headers = { 
        'CB-ACCESS-SIGN'=> @coinbaseExchange.signature('/'+uri, params, nil, method),
        'CB-ACCESS-TIMESTAMP'=> Time.now.to_i,
        'CB-ACCESS-KEY'=> @key,
        'CB-ACCESS-PASSPHRASE'=> @passphrase,
        'Content-Type' => 'application/json'
      }
    else
      headers = { 'Content-Type' => 'application/json' }
    end

    if method == :get
      r=Unirest.get(API_URL + uri, headers: headers)
    elsif method == :post
      r=Unirest.post(API_URL + uri, headers: headers, parameters: params)
    elsif method == :delete
      r=Unirest.delete(API_URL + uri, headers: headers, parameters: params)
    end
    yield r.body if block_given?
    return r.body
  end

  def get(uri, json=nil, &block)
    request(:get, uri, json, &block)
  end

  def post(uri, json=nil, &block)
    request(:post, uri, json, &block)
  end

  def delete(uri, json=nil, &block)
    request(:delete, uri, json, &block)
  end
end
