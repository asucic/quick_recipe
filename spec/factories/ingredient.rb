# frozen_string_literal: true

FactoryBot.define do
  factory :ingredient do
    name { Forgery::Basic.text }
  end
end
