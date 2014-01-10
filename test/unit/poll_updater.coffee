chai = require "chai"
expect = chai.expect
should = require "should"

PollUpdater = require "../../controllers/poll_updater"
poll_updater = new PollUpdater
PollCreator = require "../../controllers/poll_creator"
poll_creator = new PollCreator



# TODO: move to integration testing
describe "poll_updater unit test", ->

  describe "save and retrieve poll", ->

    form =
      question: "Should we go to Vegas?"
      choices:
        choice1: "Yes"
        choice2: "No"
        choice3: "Maybe"
      options:
        allow_multiple: true
        require_name: false
    form_with_id = poll_creator.add_id form

    describe "save_poll_to_db", ->
      it "should return the successfully saved object", (done) ->
        poll_creator.save_poll_to_db form_with_id, (err, res) ->
          saved_object = res[0]
          expect(saved_object).to.deep.equal(form_with_id)
          done()

          describe "retrieve_poll", ->
            it "should return the queried object", (done) ->
              { url_id } = saved_object
              poll_creator.retrieve_poll { url_id: url_id }, (err, result) ->
                expect(result).to.deep.equal(saved_object)
                done()

                describe "count_one_vote", ->

                  input =
                    choice_number: 1
                    name: "Jason"
                    url_id: url_id

                  it "should extrapolate and format form data", (done) ->
                    poll_updater.count_one_vote input, (error, response) ->
                      console.log "error: #{error}"
                      console.log "response: #{response}"
                    expect(response).to.deep.equal(expected)
                    done()
