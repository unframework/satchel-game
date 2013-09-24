define [
  'angular'
], (angular) ->
  angular.module('Gesture', []).directive 'gesture', ->
    restrict: 'A'
    scope:
      gesture: '='
      gestureItem: '='
      gestureList: '='
    link: (scope, dom) ->
      console.log 'gesture tracker created'

      root = angular.element dom[0].ownerDocument

      startHandler = (event) ->
        console.log 'gesture start'

        startTouch = if event.changedTouches then event.changedTouches[0] else event

        withCurrentTouch = (event, callback) ->
          touchList = event.changedTouches or [ event ]
          for e in touchList when e.identifier is startTouch.identifier
            callback e

        startX = startTouch.pageX
        startY = startTouch.pageY

        gestureState =
          item: scope.gestureItem
          dx: 0
          dy: 0

        scope.$apply ->
          if not scope.gestureList
            scope.gestureList = []

          if scope.gestureList.push
            scope.gestureList.push gestureState

        moveHandler = (event) ->
          withCurrentTouch event, (e) ->
            scope.$apply ->
              gestureState.dx = e.pageX - startX
              gestureState.dy = e.pageY - startY

        upHandler = () ->
          withCurrentTouch event, (e) ->
            console.log 'gesture end'

            root.unbind 'mousemove', moveHandler
            root.unbind 'touchmove', moveHandler
            root.unbind 'mouseup', upHandler
            root.unbind 'touchend', upHandler

            scope.$apply ->
              # remove gesture state from active gestures list
              if scope.gestureList
                scope.gestureList.splice scope.gestureList.indexOf(gestureState), 1

              # notify listeners
              if scope.gesture
                scope.gesture gestureState

        root.bind 'mousemove', moveHandler
        root.bind 'touchmove', moveHandler
        root.bind 'mouseup', upHandler
        root.bind 'touchend', upHandler

        # prevent browser drag
        event.preventDefault()
        false

      dom.bind 'mousedown', startHandler
      dom.bind 'touchstart', startHandler
