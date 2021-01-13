# frozen_string_literal: true

module V1
  class RedirectsController < ApplicationController
    before_action :set_link

    def index
      @link.update_attribute(:clicked, @link.clicked + 1)
      redirect_to @link.url
    end

    private

    def set_link
      @link = Link.find_by(slug: link_params[:slug])

      json_response({ message: Message.not_found('link') }, :not_found) unless @link.present?
    end

    def link_params
      params.permit(:slug)
    end
  end
end
