# frozen_string_literal: true

module ControllerSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # return valid headers
  def valid_headers
    {
      'Content-Type' => 'application/json'
    }
  end

  # return invalid headers
  def invalid_headers
    {
      'Content-Type' => 'application/json'
    }
  end
end
