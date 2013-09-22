require [
  'angular'
  './Satchel'
  './SatchelView'
], (angular, Satchel) ->
  angular.module('main', []).controller 'main', ($scope) ->
    $scope.currentGame = new Satchel()

  angular.bootstrap document.body, [
    'SatchelView'
    'main'
  ]