'use strict'

angular.module('myRecipeCollectionApp').controller 'MainCtrl', ($scope, $timeout, $resource) ->

  $scope.rows = []
  $scope.recipes = []
  $scope.pagination = {
    current: 0,
    rowSize: 4,
    pageSize: 8
  }

  $scope.totalPages = ->
    Math.ceil $scope.rows.length * $scope.pagination.rowSize / $scope.pagination.pageSize

  $scope.cookedText = (cooked) ->
    if cooked then 'You have cooked this recipe' else 'Mark this recipe as cooked'

  Recipe = $resource '/user/recipes.json'

  Recipe.query (recipes, responseHeaders) ->
    $timeout ->
      recipe.cooked = false for recipe in recipes

      $scope.recipes = recipes[..]
      $scope.rows.push recipes.splice(0, $scope.pagination.rowSize) while recipes.length > 0
