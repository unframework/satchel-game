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

      game = scope.game

      grid = dom.children().eq(0) # @todo this better
      gridWidth = grid[0].offsetWidth
      gridHeight = grid[0].offsetHeight

      scope.activeGestureList = []

      # compute legal drag target grid coordinates and pass them to callback
      withDragTarget = (item, dx, dy, callback) ->
        # grid target
        targetX = item.x + Math.round(game.grid.w * dx / gridWidth)
        targetY = item.y + Math.round(game.grid.h * dy / gridHeight)

        # bound the coordinates
        targetX = Math.min(Math.max(targetX, 0), game.grid.w - 1)
        targetY = Math.min(Math.max(targetY, 0), game.grid.h - 1)

        callback targetX, targetY

      scope.gestureTargetController = ($scope) ->
        gesture = $scope.gesture

        $scope.target =
          x: $scope.gesture.item.x
          y: $scope.gesture.item.y

        updateTarget = ->
          withDragTarget gesture.item, gesture.dx, gesture.dy, (x, y) ->
            $scope.target.x = x
            $scope.target.y = y

        $scope.$watch 'gesture.dx', updateTarget
        $scope.$watch 'gesture.dy', updateTarget

