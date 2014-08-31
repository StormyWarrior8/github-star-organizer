angular.module("Organizer")
.controller 'MainController',  ["$scope", "StaredReposService", ($scope, StaredReposService) ->

  getStaredRepos = ->
    StaredReposService.query().then((stared_repos) ->
      $scope.stared_repos = stared_repos
    )

  $scope.updateRepo = (repo_id, scope_id) ->
    console.log 'update' + repo_id + scope_id
    StaredReposService.get(repo_id).then((repo) ->
      repo.userTagList = $scope.stared_repos[scope_id].userTagList
      repo.update();
    )
  getStaredRepos()
]