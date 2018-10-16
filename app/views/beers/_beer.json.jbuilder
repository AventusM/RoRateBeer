json.extract! beer, :id, :name, :style, :brewery # beer.style, beer.brewery olemassa. Otetaan :brewery käyttöön brewery_id:n sijasta
json.url beer_url(beer, format: :json)
