require 'simplecov'
SimpleCov.start

require_relative '../lib/cbx'

CBX::API_URL = CBX::SANDBOX_API_URL
CBX::Feed::API_URL = CBX::Feed::SANDBOX_API_URL
