# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Forgery::Basic.text }
  end
end
