module V1
  class LinksController < ApplicationController
    before_action :set_link, only: %i[show create update]

    def index
      @links = Links.all
      json_response(@links)
    end

    def show
      @link.update_attribute(:clicked, @link.clicked + 1)
      redirect_to @link.url
    end

    def create
      @link = Link.new(link_params)
      @link.slug = generate_slug unless link_params[:slug].present?

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
      Link.find_by(slug: slug) ? generate_slug : slug
    end
  end
end
