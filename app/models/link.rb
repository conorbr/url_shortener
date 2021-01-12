# frozen_string_literal: true

class Link < ApplicationRecord
  before_save :format_url

  validates_presence_of :url
  validates_presence_of :slug

  validates_uniqueness_of :slug

  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates_numericality_of :clicked

  validates_length_of :url, within: 3..255, on: :create
  validates_length_of :slug, within: 1..255, on: :create

  def format_url
    return false unless url.present?

    self.url = "http://#{url}" unless url[%r{\Ahttp://}] || url[%r{\Ahttps://}]
  end
end
