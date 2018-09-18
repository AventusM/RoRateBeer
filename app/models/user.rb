class User < ApplicationRecord
  include RatingAverage # NYT voi hyödyntää average_rating - metodia, jos on mahdollista päästä käsiksi ratingeihin user.ratings - tavalla
  has_many :ratings # Käyttäjällä voi olla monta arvostelua -- access by user.ratings.params
end
