define [], ->
  class Satchel
    constructor: ->
      @grid =
        w: 10
        h: 10

      @itemList = [
        { x: 1, y: 2 }
      ]

    moveItem: (item, x, y) ->
      if x is item.x and y is item.y
        throw 'move must be to a different location'

      if x < 0 or x >= @grid.w or y < 0 or y >= @grid.h
        throw 'move is out of grid bounds'

      for otherItem in @itemList
        if otherItem.x is x and otherItem.y is y
          throw 'target grid cell occupied'

      item.x = x
      item.y = y
