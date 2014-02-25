class Good < ActiveRecord::Base
  attr_accessible :description, :retrospective_id, :votes

  belongs_to :retrospective
  belongs_to :user

  validates :description, presence: true
end
