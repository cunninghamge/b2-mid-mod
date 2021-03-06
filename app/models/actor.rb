class Actor < ApplicationRecord
  has_many :roles
  has_many :movies, through: :roles

  def self.ordered_actors
    order(:age)
  end

  def self.avg_actor_age
    average(:age)
  end

  def collaborators
    Actor.joins(:roles).where.not(id: id).distinct
  end
end
