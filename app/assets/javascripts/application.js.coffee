#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require jquery.ui.autocomplete
#= require jquery.tagsinput
#= require_tree .


$(document).ready ->
  new StaredRepoController() if $('#stared_repos-index').exists()
