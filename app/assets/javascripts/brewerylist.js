const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    breweryStatus = brewery.active? 'Active' : 'Retired' // true/falsen sijasta

    table.append('<tr>'
      + '<td>' + brewery.name + '</td>'
      + '<td>' + brewery.year + '</td>'
      + '<td>' + brewery.beers.length + '</td>'
      + '<td>' + breweryStatus + '</td>'
      + '</tr>')
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

// Järjestys vanhimman panimon mukaan
BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year - b.year; // Kävisi myös a.year > b.year. Toinen suunta == käänteinen järjestys (a.year < b.year)
  })
}

// Järjestys suurimpien määrien mukaan
BREWERIES.sort_by_beers_amount = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers.length < b.beers.length;
  })
}

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) {
    return
  }

  $("#name").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_name()
    BREWERIES.show();
  })

  $("#year").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_year()
    BREWERIES.show();
  })

  $("#amount").click((e) => {
    e.preventDefault()
    BREWERIES.sort_by_beers_amount()
    BREWERIES.show();
  })

  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.show()
  })
})