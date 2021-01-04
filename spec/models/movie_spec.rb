require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :roles}
    it {should have_many(:actors).through(:roles)}
  end
end
