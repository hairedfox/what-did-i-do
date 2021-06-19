# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tracker, type: :model do
  it { should belong_to(:user_activity) }

  it { should validate_presence_of(:tracker_type) }
  it { should validate_presence_of(:occurred_at) }
  it { should validate_presence_of(:times) }

  it do
    should define_enum_for(:tracker_type)
      .with_values(counter: 'counter')
      .backed_by_column_of_type(:string)
  end
end
