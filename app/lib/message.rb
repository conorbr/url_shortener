class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.deleted_slug
    'This slug has been deleted'
  end
end
