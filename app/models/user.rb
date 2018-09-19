class User < ApplicationRecord
  include RatingAverage # NYT voi hyödyntää average_rating - metodia, jos on mahdollista päästä käsiksi ratingeihin user.ratings - tavalla
  
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 30} # Tällä validoidaan uniikit käyttäjätunnukset, joiden minimipituus on 3

  has_many :ratings # Käyttäjällä voi olla monta arvostelua -- access by user.ratings.params
  has_many :beers, through: :ratings # Monesta-moneen-yhteys arvostelujen kautta oluihin
  
  has_many :memberships # Käyttäjä voi liittyä moneen klubiin
  has_many :beer_clubs, through: :memberships
end
