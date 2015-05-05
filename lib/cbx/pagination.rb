class CBX
  # Handles constructing the pagination portion of a URL.
  #
  module Pagination
    private

    def paginate(hash)
      hash.keys.each.with_index.reduce('?') do |string, (key, index)|
        index > 0 ? string << '&' : ''
        string << "#{key}=#{hash.fetch(key)}"
      end
    end
  end
end
