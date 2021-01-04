class Movie < ApplicationRecord
  belongs_to :studio
  has_many :roles
  has_many :actors, through: :roles

  delegate :ordered_actors, to: :actors
  delegate :avg_actor_age, to: :actors
end
