chai = require "chai"
expect = chai.expect
should = require "should"

PollUpdater = require "../../controllers/poll_updater"
poll_updater = new PollUpdater



# TODO: move to functional, add in extra collection.insert from PollCreator
describe "poll_updater unit test", ->

  describe "count_one_vote", ->

    input =
      choice_number: 1
      name: "Michael"
      url_id: 15

    it "should extrapolate and format form data", ->
      poll_updater.count_one_vote input, (error, response) ->
        console.log "error: #{error}"
        console.log "response: #{response}"
      expect(response).to.deep.equal(expected)
