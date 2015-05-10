require 'unirest'
require 'base64'
require 'openssl'
require 'json'
require 'websocket-client-simple'

# A CBX object exposes all of the functionality of the API through methods that
# return JSON objects.
#
class CBX
  DEFAULT_PRODUCT_ID = 'BTC-USD'
  API_URL = 'https://api.exchange.coinbase.com/'
  SANDBOX_API_URL = 'https://api-public.sandbox.exchange.coinbase.com/'
  require 'cbx/response'
  require 'cbx/feed'
  require 'cbx/query_parameters'
  require 'cbx/trading'
  require 'cbx/market_data'
  require 'cbx/version'
  include MarketData

  def initialize(key = nil, secret = nil, passphrase = nil)
    if key && secret && passphrase
      @key = key
      @secret = secret
      @passphrase = passphrase
      @authenticated = true
      extend Trading
    else
      @authenticated = false
    end
  end

  def authenticated?
    @authenticated
  end

  def sign(request_url = '', body = '', timestamp = nil, method = 'GET')
    body = body.to_json if body.is_a?(Hash)
    timestamp = Time.now.to_i unless timestamp

    what = "#{timestamp}#{method.upcase}#{request_url}#{body}"
    # create a sha256 hmac with the secret
    secret = Base64.decode64(@secret)
    hash  = OpenSSL::HMAC.digest('sha256', secret, what)
    Base64.strict_encode64(hash)
  end

  def request(method, uri, json = nil)
    params = json.to_json if json
    if authenticated?
      headers = { 
        'CB-ACCESS-SIGN' => sign('/' + uri, params, nil, method),
        'CB-ACCESS-TIMESTAMP' => Time.now.to_i,
        'CB-ACCESS-KEY' => @key,
        'CB-ACCESS-PASSPHRASE' => @passphrase,
        'Content-Type' => 'application/json'
      }
    else
      headers = { 'Content-Type' => 'application/json' }
    end

    if method == :get
      r = Unirest.get(API_URL + uri, headers: headers)
    elsif method == :post
      r = Unirest.post(API_URL + uri, headers: headers, parameters: params)
    elsif method == :delete
      r = Unirest.delete(API_URL + uri, headers: headers, parameters: params)
    end
    response = Response.new r
    yield response if block_given?
    response
  end

  def get(uri, json = nil, &block)
    request(:get, uri, json, &block)
  end

  def post(uri, json = nil, &block)
    request(:post, uri, json, &block)
  end

  def delete(uri, json = nil, &block)
    request(:delete, uri, json, &block)
  end
end
