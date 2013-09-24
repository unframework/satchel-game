define [ 'Satchel' ], (Satchel) ->

  describe 'Satchel', ->
    beforeEach ->
      @game = new Satchel()

    it 'should expose grid width and height', ->
      expect(@game.grid.w).toBeDefined()
      expect(@game.grid.h).toBeDefined()

    it 'should expose item list', ->
      expect(@game.itemList instanceof Array).toBe(true)

    describe 'using a test item', ->
      beforeEach ->
        @testItem = @game.itemList[0]

      it 'should expose the test item', ->
        expect(@testItem).toBeDefined()
        expect(@testItem.x).toBeDefined()
        expect(@testItem.y).toBeDefined()

      it 'should prevent zero-distance move', ->
        expect(=> @game.moveItem @testItem, @testItem.x, @testItem.y).toThrow()

      it 'should prevent out-of-bounds moves', ->
        expect(=> @game.moveItem @testItem, -1, 0).toThrow()
        expect(=> @game.moveItem @testItem, 0, @game.grid.h).toThrow()

      it 'should move the item', ->
        @game.moveItem @testItem, 5, 5
        expect(@testItem.x).toBe 5
        expect(@testItem.y).toBe 5