# frozen_string_literal: true

class UserActivitySerializer < BaseSerializer
  attributes :times, :name, :notes

  attribute :start_date do |obj|
    obj.start_date.strftime('%Y-%m-%d %H:%M:%S')
  end
end
