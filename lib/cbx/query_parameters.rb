class CBX
  # Handles constructing the pagination portion of a URL.
  #
  module QueryParameters 
    private

    # Takes a hash of Query Parameters and returns a string to tack onto the
    # request URL.
    #
    def linkify(hash)
      hash.keys.each.with_index.reduce('?') do |string, (key, index)|
        index > 0 ? string << '&' : ''
        string << "#{key}=#{hash.fetch(key)}"
      end
    end
  end
end
