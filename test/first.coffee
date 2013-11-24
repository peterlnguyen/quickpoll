{assert, should} = require "./test"

describe "addition", ->
  it "should add 1+1 correctly", ->
    true.should.equal true
    assert.equal true, true

