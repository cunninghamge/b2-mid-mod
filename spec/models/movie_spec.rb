require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :roles}
    it {should have_many(:actors).through(:roles)}
  end

  describe 'instance methods' do
    before :each do
      @studio_1 = Studio.create!(name: "Universal Pictures", location: "Universal City, CA")
      @movie_1 = @studio_1.movies.create!(title: "Cats", creation_year: 2019, genre: "musical")
      @actor_1 = Actor.create!(name: "Taylor Swift", age: 31)
      @actor_2 = Actor.create!(name: "Judi Dench",age: 86)
      @actor_3 = Actor.create!(name: "Jason Derulo",age: 32)
      @movie_1.actors = [@actor_1, @actor_2, @actor_3]
    end

    it '#ordered_actors' do
      ordered = [@actor_1, @actor_3, @actor_2]
      expect(@movie_1.ordered_actors).to eq(ordered)
    end

    it '#avg_actor_age' do
      avg = Actor.average(:age)
      expect(@movie_1.avg_actor_age).to eq(avg)
    end
  end
end
