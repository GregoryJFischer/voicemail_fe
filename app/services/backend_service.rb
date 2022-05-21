class BackendService
  class << self
    def get_user(user_id)
      response = conn.get("/api/v1/users/#{user_id}")

      parse_response(response)
    end

    def find_or_create_user(user_params)
      parse_response(post('users', user_params))
    end

    def create_session(user_params)
      parse_response(post("sessions", user_params))
    end

    def update_address(user_id, address_params)
      patch("users/#{user_id}", address_params)
    end

    def create_letter(url: 'letters', letter_attributes:)
      response = post('letters', letter_attributes)
      parse_response(response)
    end

    def preview_letter(url: 'letters/preview', letter_attributes:)
      response = post(url, letter_attributes)
      parse_response(response)
    end

    def send_letter(email, url: 'letters/send')
      response = post(url, email)
      parse_response(response)
    end

    def representatives(user_id)
      response = conn.get("/api/v1/users/#{user_id}/representatives")

      parse_response(response)
    end

  private

    def post(url, json)
      conn.post do |req|
        req.url "/api/v1/#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = json.to_json
      end

    end

    def patch(url, body)
      conn.patch do |req|
        req.url "/api/v1/#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
      end
    end

    def parse_response(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: ENV['BASE_URL'])
    end
  end
end