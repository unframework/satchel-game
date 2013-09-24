define [
  'angular'
], (angular) ->
  angular.module('Gesture', []).directive 'gesture', ->
    restrict: 'A'
    scope:
      gesture: '&'
      gestureItem: '='
      gestureList: '='
    link: (scope, dom) ->
      console.log 'gesture tracker created'

      root = angular.element dom[0].ownerDocument

      # @todo support touch events
      dom.bind 'mousedown', (e) ->
        console.log 'gesture start'

        startX = e.pageX
        startY = e.pageY

        gestureState =
          item: scope.gestureItem
          dx: 0
          dy: 0

        scope.$apply ->
          if not scope.gestureList
            scope.gestureList = []

          if scope.gestureList.push
            scope.gestureList.push gestureState

        moveHandler = (e) ->
          scope.$apply ->
            gestureState.dx = e.pageX - startX
            gestureState.dy = e.pageY - startY

        upHandler = () ->
          console.log 'gesture end'

          root.unbind 'mousemove', moveHandler
          root.unbind 'mouseup', upHandler

          scope.$apply ->
            # remove gesture state from active gestures list
            if scope.gestureList
              scope.gestureList.splice scope.gestureList.indexOf(gestureState), 1

            # notify listeners
            if scope.gesture
              scope.gesture gestureState

        root.bind 'mousemove', moveHandler
        root.bind 'mouseup', upHandler

        # prevent browser drag
        e.preventDefault()
        false
