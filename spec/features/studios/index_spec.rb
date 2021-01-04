require 'rails_helper'

RSpec.describe 'Studios Index' do
  before :each do
    @studio_1 = Studio.create!(name: "Universal Pictures", location: "Universal City, CA")
    @studio_2 = Studio.create!(name: "Columbia Pictures", location: "Los Angeles, CA")
    @movie_1 = @studio_1.movies.create!(title: "Cats", creation_year: 2019, genre: "musical")
    @movie_2 = @studio_1.movies.create!(title: "Jurassic World", creation_year: 2015, genre: "action")
  end

  it 'lists all of the movie studios' do
    visit studios_path

    expect(page).to have_content(@studio_1.name)
    expect(page).to have_content(@studio_2.name)
  end

  it 'lists the names of each of the movies for each studio' do
    visit studios_path

    within("#studio-#{@studio_1.id}") do
      expect(page).to have_content(@movie_1.title)
      expect(page).to have_content(@movie_2.title)
    end
  end
end
