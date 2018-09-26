class User < ApplicationRecord
  include RatingAverage # NYT voi hyödyntää average_rating - metodia, jos on mahdollista päästä käsiksi ratingeihin user.ratings - tavalla

  # User voi hyödyntää uusia metodeja (tässä salasanan autentikointi) https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  has_secure_password
  
  validates :username, uniqueness: true, length: {minimum: 3, maximum: 30} # Tällä validoidaan uniikit käyttäjätunnukset, joiden minimipituus on 3
  validates :password, length: {minimum: 4}, format: { with: /^(?=.*[A-Z])(?=.*[0-9])/, :multiline => true } # Salasanan pituus väh. 4 merkkiä, sisältää vähintään yhden ison kirjaimen sekä vähintään yhden numeron

  # dependent - oliot poistetaan, jos niihin liittyvä käyttäjä poistetaan
  # dependent - oliot poistetaan, jos niihin liittyvä käyttäjä poistetaan
  # dependent - oliot poistetaan, jos niihin liittyvä käyttäjä poistetaan
  
  has_many :ratings, dependent: :destroy # Käyttäjällä voi olla monta arvostelua -- access by user.ratings.params
  has_many :beers, through: :ratings # Monesta-moneen-yhteys arvostelujen kautta oluihin
  
  has_many :memberships, dependent: :destroy # Käyttäjä voi liittyä moneen klubiin
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    user_ratings = ratings.sort_by{ |r| r.score }
    favourite_rating = user_ratings.last
    favourite_rating.beer # Implicit return
    # ratings.order(score: :desc).limit(1).first.beer # optimoitu versio
  end

  def favorite_style
    return nil if favorite_beer.nil?
  end
end
