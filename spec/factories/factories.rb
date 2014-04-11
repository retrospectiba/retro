# encoding : utf-8
require 'factory_girl'

FactoryGirl.define do
  factory :user do
    id                    123456
    email                 'zekitow@gmail.com'
    name                  'José Ribeiro'
    team_id               1
    password              '123456'
    password_confirmation '123456'
  end

  factory :retrospective do
    name 'Sprint# 1 - Mastering on Groselha'
  end

  factory :team do
    name 'Sprint# 1 - Mastering on Groselha'
    user_id 1
  end

  factory :invalid_retrospective, parent: :retrospective do
    name nil
  end
end
