module V2
  class LinksController < ApplicationController
    def index
      json_response({ message: 'Its always important to version an API' })
    end
  end
end
