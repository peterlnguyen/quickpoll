chai = require "chai"
expect = chai.expect
should = require "should"

PollUpdator = require "../../controllers/poll_creator"
poll_updater = new PollUpdater



# TODO: move to functional, add in extra collection.insert from PollCreator
describe "poll_updater unit test", ->

  describe "count_one_vote", ->

    input =
      choice_number: 1
      name: "Michael"
      url_id: 15
      req_res:
        req:
        res:

    it "should extrapolate and format form data", ->
      result = poll_creator.get_formatted_body input
      expect(result).to.deep.equal(expected)
