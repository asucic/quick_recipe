# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    name { Forgery::Basic.text }
    people_quantity { Forgery::Basic.number }
    prep_time { Forgery::Basic.text }
    cook_time { Forgery::Basic.text }
    total_time { Forgery::Basic.text }
    nb_comments { Forgery::Basic.text }

    association :author
    association :budget
    association :difficulty
  end
end
