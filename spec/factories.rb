FactoryBot.define do
  factory :user do
    username { "Anton" }
    password { "Test123"}
    password_confirmation { "Test123"}
  end

  factory :brewery do
    name { "Coors brewing company" }
    year { 1873 }
  end

  factory :beer do
    name { "Coors light" }
    style { "crap"}
    brewery # beer.brewery (factory)
  end

  factory :rating do
    # Score luodaan manuaalisesti, jos käytetään factoryn ratingia (tätä), niin olut tulee olemaan factoryn olut
    beer # asetetaan rating.beer näin (factory)
  end
end