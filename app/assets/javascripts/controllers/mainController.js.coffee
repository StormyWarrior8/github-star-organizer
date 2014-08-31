angular.module("Organizer")
.controller 'MainController',  ["$scope", "$http", ($scope, $http) ->

  loadStaredRepos = ->
    $http.get('./stared_repos.json').success((data) ->
      console.log data
      $scope.stared_repos = data
    )

  loadStaredRepos()
]