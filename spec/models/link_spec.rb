require 'rails_helper'

# Test suite for Link model
RSpec.describe Link, type: :model do
  # Validation tests
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:url) }
  it { should validate_numericality_of(:clicked) }
end