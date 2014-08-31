# register all modules
angular.module('Organizer.services', [
  'ngRoute'
  'ngResource'
  'rails'
])
angular.module('Organizer', [
  'Organizer.services'
])