require 'rails_helper'

RSpec.describe "Movie Show" do
  before :each do
    @studio_1 = Studio.create!(name: "Universal Pictures", location: "Universal City, CA")
    @movie_1 = @studio_1.movies.create!(title: "Cats", creation_year: 2019, genre: "musical")
    @actor_1 = Actor.create!(name: "Taylor Swift", age: 31)
    @actor_2 = Actor.create!(name: "Judi Dench",age: 86)
    @actor_3 = Actor.create!(name: "Jason Derulo",age: 32)
    @movie_1.actors = [@actor_1, @actor_2, @actor_3]

    visit movie_path(@movie_1)
  end

  it 'displays the attributes of the movie' do
    expect(page).to have_content(@movie_1.title)
    expect(page).to have_content(@movie_1.creation_year)
    expect(page).to have_content(@movie_1.genre)
  end

  it 'lists all of the actors from youngest to oldest' do
    expect(@actor_1.name).to appear_before(@actor_3.name)
    expect(@actor_3.name).to appear_before(@actor_2.name)
  end

  it 'shows the age of each actor' do
    within("#actor-#{@actor_1.id}") {expect(page).to have_content(@actor_1.age)}
    within("#actor-#{@actor_2.id}") {expect(page).to have_content(@actor_2.age)}
    within("#actor-#{@actor_3.id}") {expect(page).to have_content(@actor_3.age)}
  end

  it 'shows the average age of all of the actors' do
    avg = Actor.average(:age).round(1)
    expect(page).to have_content("Average Age: #{avg} years")
  end
end
