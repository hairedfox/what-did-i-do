# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  subject { build(:activity) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:action_type) }
  it do
    should define_enum_for(:action_type)
      .with_values(counting: 'counting')
      .backed_by_column_of_type(:string)
  end
end
