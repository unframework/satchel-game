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
    link: (scope) ->
      console.log 'game view created'

      scope.activeGestureList = []
