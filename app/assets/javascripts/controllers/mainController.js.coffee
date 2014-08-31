angular.module("Organizer")
.controller 'MainController',  ["$scope", "StaredReposService", ($scope, StaredReposService) ->

  getStaredRepos = ->
    StaredReposService.query().then((stared_repos) ->
      $scope.stared_repos =  stared_repos
    )

  getStaredRepos()
]