require 'rails_helper'

describe Movie, type: :model do
  it "is a flop if the total gross is less than $50 million" do
    movie = Movie.new(total_gross: 40000000.00)

    expect(movie.flop?).to be_truthy
  end

  it "shows the total gross if greater than $50 million" do
    movie = Movie.new(total_gross: 50000000.00)

    expect(movie.flop?).to be_falsey
  end
end
