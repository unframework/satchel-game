define [
  'angular'
  'text!./SatchelView.html'
  'Gesture'
], (angular, template) ->
  angular.module('SatchelView', ['Gesture']).directive 'satchelView', ->
    restrict: 'E'
    replace: true
    template: template
    scope:
      game: '='
    link: (scope, dom) ->
      console.log 'game view created'

      grid = dom.children().eq(0) # @todo this better
      gridWidth = grid[0].offsetWidth
      gridHeight = grid[0].offsetHeight

      scope.activeGestureList = []

      scope.gestureTargetController = ($scope) ->
        $scope.target =
          x: $scope.gesture.item.x
          y: $scope.gesture.item.y

        updateTarget = ->
          $scope.target.x = $scope.gesture.item.x + Math.round($scope.game.grid.w * $scope.gesture.dx / gridWidth)
          $scope.target.y = $scope.gesture.item.y + Math.round($scope.game.grid.h * $scope.gesture.dy / gridHeight)

        $scope.$watch 'gesture.dx', updateTarget
        $scope.$watch 'gesture.dy', updateTarget

