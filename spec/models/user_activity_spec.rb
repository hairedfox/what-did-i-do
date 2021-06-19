# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserActivity, type: :model do
  it { should belong_to(:activity) }
  it { should belong_to(:user) }
end
