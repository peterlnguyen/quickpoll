chai = require "chai"
expect = chai.expect
should = require "should"
assert = require "assert"

PollUpdater = require "../../controllers/poll_updater"
poll_updater = new PollUpdater
PollCreator = require "../../controllers/poll_creator"
poll_creator = new PollCreator



describe "insert_and_update integration, tests for poll_updater unit test", ->

  describe "save and retrieve poll", ->

    form =
      body:
        question: "Should we go to Vegas?"
        choices: ["Yes", "No", "Maybe"]
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

                describe "count_vote_list", ->

                  req_bob =
                    body:
                      "Yes": "on"
                      "No": "on"
                      "Maybe": "on"
                      url_id: url_id
                      name: "Bob"

                  req_jason =
                    body:
                      "Yes": "on"
                      "No": "on"
                      "Maybe": "on"
                      url_id: url_id
                      name: "Jason"

                  { update_query } = poll_updater.get_query_params req_jason

                  it "should submit vote and return success", (done) ->
                    poll_updater.count_vote_list { update_query: update_query, url_id: url_id },
                      (update_error, update_response) ->
                        should.not.exist(update_error)
                        update_response.should.equal(1)
                        done()

                        describe "retrieve_poll", ->
                          it "should return the newly updated object", (done) ->
                            poll_updater.retrieve_poll { url_id }, (updated_error, updated_result) ->
                              #console.log "results: ", updated_result
                              should.exist(updated_result)
                              should.not.exist(updated_error)
                              assert.equal ["Jason", "Bob"], updated_result.poll_results.choices["Yes"].voter_names
                              assert.equal ["Jason", "Bob"], updated_result.poll_results.choices["Maybe"].voter_names
                              done()

#                        { update_query } = poll_updater.get_query_params req_bob
#                        #console.log update_query
#
#                        describe "submitting another vote", ->
#                          it "should submit vote and return success", (done) ->
#                            poll_updater.count_vote_list { update_query: update_query, url_id: url_id },
#                              (update_error, update_response) ->
#                                #console.log "updated response: "
#                                should.not.exist(update_error)
#                                update_response.should.equal(1)
#                                done()
#
#                                describe "retrieve_poll", ->
#                                  it "should return the newly updated object", (done) ->
#                                    poll_updater.retrieve_poll { url_id: url_id }, (updated_error, updated_result) ->
#                                      #console.log "results: ", updated_result
#                                      should.exist(updated_result)
#                                      should.not.exist(updated_error)
#                                      assert.equal ["Jason", "Bob"], updated_result.poll_results.choices["Yes"].voter_names
#                                      assert.equal ["Jason", "Bob"], updated_result.poll_results.choices["Maybe"].voter_names
#                                      done()


