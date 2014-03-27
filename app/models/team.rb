class Team < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :user
  has_many :retrospective
end
