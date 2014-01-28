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

  describe "get_query_params, generate_push_query, generate_increment_count_query", ->

    input =
      body:
        first_choice: "on"
        second_choice: "on"
        third_choice: "on"
        url_id: "fake_id"
        name: "John Doe"
    
    expected =
      update_query:
        $push:
          "poll_results.choices.first_choice.voter_names": "John Doe"
          "poll_results.choices.second_choice.voter_names": "John Doe"
          "poll_results.choices.third_choice.voter_names": "John Doe"
        $inc:
          "poll_results.choices.first_choice.count": 1
          "poll_results.choices.second_choice.count": 1
          "poll_results.choices.third_choice.count": 1
      url_id: "fake_id"

    it "should return an object with push_query and url_id", ->
      result = poll_updater.get_query_params input
      expect(result).to.deep.equal(expected)
