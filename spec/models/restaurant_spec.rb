require 'spec_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    restaurant0 = Restaurant.create(name: "Moe's Tavern")
    restaurant0.save(:validate => false)
    restaurant = Restaurant.new(name: "Moe's Tavern")
    restaurant.save(:validate => false)
    expect(restaurant).to have(1).error_on(:name)
  end
end
