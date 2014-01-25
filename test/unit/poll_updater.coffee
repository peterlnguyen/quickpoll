chai = require "chai"
expect = chai.expect
should = require "should"

PollUpdater = require "../../controllers/poll_updater"
poll_updater = new PollUpdater



describe "poll_updater unit test", ->

  describe "votes_to_list", ->

    input =
      first_choice: "on"
      second_choice: "on"
      another_choice: "on"
      name: "blah"
      url_id: "foobar"

    expected = [ "first_choice", "second_choice", "another_choice" ]

    it "should filter name and url_id", ->
      result = poll_updater.votes_to_list input
      expect(result).to.deep.equal(expected)


