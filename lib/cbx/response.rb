class CBX
  class Response
    attr_reader :body
    attr_reader :cb_after
    attr_reader :cb_before
    attr_reader :code

    def initialize(unirest_http_response)
      @body = unirest_http_response.body
      @code = unirest_http_response.code
      @cb_after = unirest_http_response.headers[:cb_after]
      @cb_before = unirest_http_response.headers[:cb_before]
      @cb_total_records = unirest_http_response.headers[:cb_total_records]
    end

  end
end
