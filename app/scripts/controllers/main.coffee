'use strict'

angular.module('myRecipeCollectionApp').controller 'MainCtrl', ($scope, $timeout, $resource, $filter) ->

  $scope.rows = []
  $scope.filteredRecipes = []
  $scope.recipes = []
  $scope.pagination = {
    current: 0,
    rowSize: 4,
    pageSize: 8
  }

  $scope.recipeFilter = ''

  $scope.$watch 'recipeFilter', (filter) ->
    if filter.length == 0
        $scope.filteredRecipes = $scope.recipes
    else if filter.length >= 3
        $scope.filteredRecipes = $filter('filter')($scope.recipes, filter)

  $scope.$watch 'filteredRecipes.length', (length) ->
    return unless length > 0

    recipes = $scope.filteredRecipes

    $scope.rows = []
    $scope.rows.push recipes.splice(0, $scope.pagination.rowSize) while recipes.length > 0

  $scope.totalPages = ->
    Math.ceil $scope.rows.length * $scope.pagination.rowSize / $scope.pagination.pageSize

  $scope.cookedText = (cooked) ->
    if cooked then 'You have cooked this recipe' else 'Mark this recipe as cooked'

  Recipe = $resource '/user/recipes.json'

  Recipe.query (recipes, responseHeaders) ->
    $timeout ->
      recipe.cooked = false for recipe in recipes

      $scope.recipes = recipes[..]
      $scope.filteredRecipes = $scope.recipes[..]
