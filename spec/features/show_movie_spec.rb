require 'rails_helper'

describe "Viewing the individual movie pages" do

  it "shows the movie" do

    movie = Movie.create(movie_attributes(total_gross: 318412101.00))
    
    visit "http://example.com/movies/#{movie.id}"

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description[0..10])
    expect(page).to have_text(movie.released_on)
  end

  it "shows the total gross if total gross exceeds $50 million" do
    movie = Movie.create(movie_attributes(total_gross: 60000000.00))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50 million" do
    movie = Movie.create(movie_attributes(total_gross: 0))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end

end
