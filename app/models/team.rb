class Team < ActiveRecord::Base
  attr_accessible :name, :po_name
  has_many :user
end
