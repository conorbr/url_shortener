# frozen_string_literal: true

module ControllerSpecHelper

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
