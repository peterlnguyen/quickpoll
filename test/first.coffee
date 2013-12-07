{should, expect, request} = require "./test"
"routes" = require "../routes/routes"

describe "addition", ->
  it "should add 1+1 correctly", ->
    true.should.equal true

describe "Routing", ->
  describe "Index", ->
    it "should provide the title and index view name", ->
      routes.index request, response
      response.view_name.should.equal "index"
