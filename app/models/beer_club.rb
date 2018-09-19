class BeerClub < ApplicationRecord
  has_many :memberships # Klubilla on monta jäsenyyttä
  has_many :members, through: :memberships, source: :user # Klubilla on monta jäsentä jäsenyyksien kautta
end
