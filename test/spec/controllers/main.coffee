'use strict'

describe 'Controller: MainCtrl', () ->

  # load the controller's module
  beforeEach module 'myRecipeCollectionApp'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller) ->
    scope = {}
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }
