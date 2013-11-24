Test = require "./test"
# {assert, should} = require "./test"

class Main extends Test
  describe "addition", ->
    it "should add 1+1 correctly", ->
      true.should.equal true

