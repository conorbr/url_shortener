class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url, :slug, :short, :created_at, :updated_at
end
