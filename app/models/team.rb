class Team < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :users
  has_many :retrospectives
end
