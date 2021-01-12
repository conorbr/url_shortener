# spec/models/user_spec.rb
require 'rails_helper'

# Test suite for Link model
RSpec.describe Link, type: :model do

  # Validation tests
  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:url) }
  it { should validate_numericality_of(:clicked) }
end