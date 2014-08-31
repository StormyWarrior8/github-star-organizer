# register all modules
angular.module('Organizer.services', [
  'ngRoute'
  'ngResource'
])
angular.module('Organizer', [
  'Organizer.services'
])