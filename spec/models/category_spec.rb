# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:entity_categories) }
  it { should have_many(:activities) }

  it { should validate_presence_of(:name) }
end
