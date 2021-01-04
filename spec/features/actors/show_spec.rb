require 'rails_helper'

RSpec.describe "Actor Show" do
  before :each do
    @studio_1 = Studio.create!(name: "Universal Pictures", location: "Universal City, CA")
    @movie_1 = @studio_1.movies.create!(title: "Cats", creation_year: 2019, genre: "musical")
    @movie_2 = @studio_1.movies.create!(title: "Jurassic World", creation_year: 2015, genre: "action")
    @movie_3 = @studio_1.movies.create!(title: "28 Weeks Later", creation_year: 2007, genre: "horror")

    @actor_1 = Actor.create!(name: "Taylor Swift", age: 31)
    @actor_2 = Actor.create!(name: "Judi Dench",age: 86)
    @actor_3 = Actor.create!(name: "Jason Derulo",age: 32)
    @actor_4 = Actor.create!(name: "Idris Elba", age: 48)
    @actor_5 = Actor.create!(name: "Chris Pratt", age: 41)
    @actor_6 = Actor.create!(name: "Brad Pitt", age: 57)

    @movie_1.actors = [@actor_2, @actor_1, @actor_3]
    @movie_2.actors = [@actor_2, @actor_4, @actor_5]
    @movie_3.actors = [@actor_2, @actor_4]

    visit actor_path(@actor_2)
  end

  it 'displays the attributes of the actor' do
    expect(page).to have_content(@actor_2.name)
    expect(page).to have_content(@actor_2.age)
  end

  describe 'displays a unique list of all the actors this one has worked with' do
    it 'shows a list of actors' do
      within("#collaborators") do
        expect(page).to have_content(@actor_1.name)
        expect(page).to have_content(@actor_3.name)
        expect(page).to have_content(@actor_4.name)
        expect(page).to have_content(@actor_5.name)
      end
      expect(page).not_to have_content(@actor_6.name)
    end

    it 'does not show duplicates' do
      expect(page).to have_content(@actor_4.name, count: 1)
    end
  end
end
