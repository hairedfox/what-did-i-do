# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_activities) }
  it { should have_many(:activities) }
end
