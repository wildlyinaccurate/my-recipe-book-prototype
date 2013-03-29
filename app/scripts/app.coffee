'use strict'

angular.module('myRecipeCollectionApp', ['filters', 'ngResource'])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'

# Simple 'startFrom' filter to aid pagination
angular.module('filters', [])
  .filter 'startFrom', ->
    (input, start) ->
      input.slice start

  .filter 'truncate', ->
    (text, length = 100, end = '...') ->
      text.substring(0, length - end.length) + end
