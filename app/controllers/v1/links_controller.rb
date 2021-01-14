# frozen_string_literal: true

module V1
  class LinksController < ApplicationController
    include ActiveModelSerializers

    before_action :set_link, only: %i[show update destroy show]

    def index
      @links = Link.all
      render json: @links, serialize_each: LinkSerializer
    end

    def show
      render json: @link, serialize_each: LinkSerializer
    end

    def create
      @link = Link.new(link_params)
      @link.update_attribute(:slug, generate_slug(link_params[:slug]))

      return json_response(@link, :created) if @link.save

      json_response({ message: @link.errors.first }, :unprocessable_entity)
    end

    def update
      @link.update(link_params.except(:slug))
      @link.update_attribute(:slug, generate_slug(link_params[:slug])) if link_params[:slug]

      return json_response(@link, :ok) if @link.save

      json_response({ message: @link.errors.full_messages }, 422)
    end

    def destroy
      @link.delete
      json_response({ message: Message.deleted_link }, :ok)
    end

    private

    def set_link
      @link = Link.find(link_params[:id])

      json_response({ message: Message.not_found('link') }, :not_found) unless @link.present?
    end

    def link_params
      params.permit(:slug, :url, :id)
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
