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

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) {
    return
  }

  $.getJSON('breweries.json', (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.show()
  })
})