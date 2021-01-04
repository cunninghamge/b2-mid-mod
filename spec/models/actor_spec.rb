require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many :roles}
    it {should have_many(:movies).through(:roles)}
  end

  describe 'class methods' do
    before :each do
      @actor_1 = Actor.create!(name: "Taylor Swift", age: 31)
      @actor_2 = Actor.create!(name: "Judi Dench",age: 86)
      @actor_3 = Actor.create!(name: "Jason Derulo",age: 32)
    end

    it '.ordered_actors' do
      ordered = [@actor_1, @actor_3, @actor_2]
      expect(Actor.ordered_actors).to eq(ordered)
    end

    it '.avg_actor_age' do
      expect(Actor.avg_actor_age.round(2)).to eq(49.67)
    end
  end

  describe 'instance methods' do
    it '#collaborators' do
      @studio_1 = Studio.create!(name: "Universal Pictures", location: "Universal City, CA")
      @movie_1 = @studio_1.movies.create!(title: "Cats", creation_year: 2019, genre: "musical")
      @movie_2 = @studio_1.movies.create!(title: "Jurassic World", creation_year: 2015, genre: "action")
      @movie_3 = @studio_1.movies.create!(title: "28 Weeks Later", creation_year: 2007, genre: "horror")

      @actor_1 = Actor.create!(name: "Taylor Swift", age: 31)
      @actor_2 = Actor.create!(name: "Judi Dench",age: 86)
      @actor_3 = Actor.create!(name: "Jason Derulo",age: 32)
      @actor_4 = Actor.create!(name: "Idris Elba", age: 48)
      @actor_5 = Actor.create!(name: "Chris Pratt", age: 41)

      @movie_1.actors = [@actor_2, @actor_1, @actor_3]
      @movie_2.actors = [@actor_2, @actor_4, @actor_5]
      @movie_3.actors = [@actor_2, @actor_4]

      expected = [@actor_1, @actor_3, @actor_4, @actor_5]
      expect(@actor_2.collaborators.to_set).to eq(expected.to_set)
    end
  end
end
