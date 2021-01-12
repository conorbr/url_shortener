module V1
  class LinksController < ApplicationController
    before_action :set_link, only: %i[show update destroy]

    def index
      @links = Link.all
      json_response(@links)
    end

    def show
      @link.update_attribute(:clicked, @link.clicked + 1)
      redirect_to @link.url
    end

    def create
      @link = Link.new(link_params)
      @link.update_attribute(:slug, generate_slug(link_params[:slug]))

      json_response(@link) if @link.save
    end

    def update
      @link.update(link_params)
    end

    def destroy
      @link.destroy
      json_response({ message: Message.deleted_link }, :deleted)
    end

    private

    def set_link
      @link = Link.find_by(slug: link_params[:slug]) || json_response({ message: Message.not_found('link') }, :not_found)
    end

    def link_params
      params.permit(:slug, :url, :link)
    end

    def generate_slug(slug_param = nil)
      slug = slug_param || SecureRandom.uuid[0..5]

      # if slug is taken add random characters to the end
      Link.find_by(slug: slug) ? slug.concat(SecureRandom.uuid[0..2]) : slug

      # if slug is still taken call self again
      Link.find_by(slug: slug) ? generate_slug(slug_param) : slug
    end
  end
end
