# defining all routes
angular.module('Organizer').config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/stared_repos', ({templateUrl: '../assets/starred_repos.html.haml ', controller: 'MainController'})
    $locationProvider.html5Mode true
]