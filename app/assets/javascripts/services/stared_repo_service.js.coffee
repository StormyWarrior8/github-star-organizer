app = angular.module("Organizer.services")

app.factory("StaredReposService",[
  'railsResourceFactory'
  (railsResourceFactory) ->
  #$resource("/stared_repos/:id", {id: "@id"}, {update: {method: "PUT"}})
    resource = railsResourceFactory
      url: '/stared_repos'
      name: 'stared_repo'
])