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
end
