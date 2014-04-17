class Retrospective < ActiveRecord::Base
  attr_accessible :name, :start_at, :finish_at, :team_id, :target

  belongs_to :team

  has_many :goods
  has_many :bads

  validates :name, :team_id, :target, presence: true
  validates :start_at , presence: true, if: :finish_at?
  validates :finish_at, presence: true, if: :start_at?
end
