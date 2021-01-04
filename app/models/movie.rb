class Movie < ApplicationRecord
  belongs_to :studio
  has_many :roles
  has_many :actors, through: :roles

  delegate :ordered_actors, to: :actors
end
