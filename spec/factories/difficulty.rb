# frozen_string_literal: true

FactoryBot.define do
  factory :difficulty do
    name { Forgery::Basic.text }
  end
end
