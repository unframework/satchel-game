define [
  'angular'
  'text!./SatchelView.html'
], (angular, template) ->
  angular.module('SatchelView', []).directive 'satchelView', ->
    restrict: 'E'
    replace: true
    template: template
    scope:
      game: '='
    link: (scope) ->
      console.log 'game view created'
