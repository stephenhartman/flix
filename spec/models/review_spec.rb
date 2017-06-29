require 'rails_helper'

describe "A review" do
  it "belongs to a movie" do
    movie = Movie.create(movie_attributes)
    review = movie.reviews.new(review_attributes)
    expect(review.movie).to eq(movie)
  end

  it "with example attributes is valid" do
    movie = Movie.create(movie_attributes)
    review = Review.new(review_attributes)
    review.movie = movie
    expect(review.valid?).to eq(true)
  end

  it "requires a name" do
    review = Review.new(name: "")
    review.valid?
    expect(review.errors[:name].any?).to eq(true)
  end

  it "requires a comment" do
    review = Review.new(comment: "")
    review.valid?
    expect(review.errors[:comment].any?).to eq(true)
  end

  it "requires a comment of over three characters" do
    review = Review.new(comment: "x" * 3)
    review.valid?
    expect(review.errors[:comment].any?).to eq(true)
  end

  it "accepts star values of 1 through 5" do
    stars = [1, 2, 3, 4, 5]
    stars.each do |star|
      review = Review.new(stars: star)
      review.valid?
      expect(review.errors[:stars].any?).to eq(false)
    end
  end

  it "rejects invalid star values" do
    stars = [0, 0, 6]
    stars.each do |star|
      review = Review.new(stars: star)
      review.valid?
      expect(review.errors[:stars].any?).to eq(true)
      expect(review.errors[:stars].first).to eq("must be between 1 and 5")
    end
  end

  it "calculates the average number of review stars" do
    movie = Movie.create(movie_attributes)

    movie.reviews.create(review_attributes(stars: 1))
    movie.reviews.create(review_attributes(stars: 3))
    movie.reviews.create(review_attributes(stars: 5))

    expect(movie.average_stars).to eq(3)
  end
end
