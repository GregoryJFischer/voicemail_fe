class BackendService
  class << self
    def get_user(user_id)
      fetch("/users/#{user_id}")
    end

    def find_or_create_user(user_params)
      post("/users", user_params)
    end

    def update_address(address_params, user_id)
      patch("/users/#{user_id}", address_params)
    end

    def representatives(user_id)
      fetch("/users/#{user_id}/representatives")
    end

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
  end
end