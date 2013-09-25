class Good < ActiveRecord::Base
  attr_accessible :description, :retrospective_id, :votes

  belongs_to :retrospective

  validates :description, uniqueness: true, presence: true
end
