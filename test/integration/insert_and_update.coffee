chai = require "chai"
expect = chai.expect
should = require "should"

PollUpdater = require "../../controllers/poll_updater"
poll_updater = new PollUpdater
PollCreator = require "../../controllers/poll_creator"
poll_creator = new PollCreator



describe "insert_and_update integration, tests for poll_updater unit test", ->

  describe "save and retrieve poll", ->

    form =
      body:
        question: "Should we go to Vegas?"
        choice1: "Yes"
        choice2: "No"
        choice3: "Maybe"
        allow_multiple: true
        require_name: false
    formatted_form = poll_creator.get_formatted_body form
    form_with_id = poll_creator.add_id formatted_form

    describe "save_poll_to_db", ->
      it "should return the successfully saved object", (done) ->
        poll_creator.save_poll_to_db form_with_id, (save_error, save_response) ->
          should.not.exist(save_error)
          saved_object = save_response[0]
          expect(saved_object).to.deep.equal(form_with_id)
          done()

          describe "retrieve_poll", ->
            it "should return the queried object", (done) ->
              # unique identifier
              { url_id } = saved_object
              poll_creator.retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_result) ->
                should.not.exist(retrieve_error)
                expect(retrieve_result).to.deep.equal(saved_object)
                done()

                describe "count_one_vote", ->

                  input =
                    choice_number: 1
                    name: "Jason"
                    url_id: url_id

                  it "should submit vote and return success", (done) ->
                    poll_updater.count_one_vote input, (update_error, update_response) ->
                      should.not.exist(update_error)
                      update_response.should.equal(1)
                      done()

                      describe "retrieve_poll", ->
                        it "should return the newly updated object", (done) ->
                          poll_creator.retrieve_poll { url_id: url_id }, (updated_error, updated_result) ->
                            should.not.exist(updated_error)
                            expect(updated_result.poll_results.choices[1].voter_names).to.contain("Jason")
                            done()


