should = require "should"
expect = require "expect.js"
request = require "request"
express = require "express"
app = express()

#describe "addition", ->
#  it "should add 1+1 correctly", ->
#    true.should.equal true
#
#describe "Routing", ->
#
#  describe "GET /", ->
#    it "should response with index page", (done) ->
#      request(app)
#        .get("/")
#        .set("Accept", "application/json")
#        .expect("Content-Type", /json/)
#        .expect(200, done)
