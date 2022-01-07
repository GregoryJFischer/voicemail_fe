class BackendService
  class << self
    def fetch(url)
      parse_response(conn.get(url))
    end

    def post(url, json)
      conn.post do |req|
        req.url "/api/v1/#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = json
      end
    end

    def patch(url, json)
      conn.patch do |req|
        req.url "/api/v1/#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = json
      end
    end

    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: "http://localhost:5000")
    end

    def representatives(address)
      fetch("/api/v1/representatives?#{address}")
    end
  end
end
