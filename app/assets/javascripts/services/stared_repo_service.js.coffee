app = angular.module("Organizer.services")

app.factory "StaredRepo", ($resource) ->
  $resource("/stared_repos/:id", {id: "@id"}, {update: {method: "PUT"}, query: {method: 'GET', isArray: false }})