# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    name { Forgery::Basic.text }
  end
end
