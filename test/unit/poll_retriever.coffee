chai = require "chai"
expect = chai.expect
should = require "should"

PollCreator = require "../../controllers/poll_creator"
poll_creator = new PollCreator
PollRetriever = require "../../controllers/poll_retriever"
poll_retriever = new PollRetriever



describe "poll_creator unit test", ->

  describe "save and retrieve poll", ->

    form =
      poll_query:
        question: "Should we go to Vegas?"
        choices: ["Yes", "No", "Maybe"]
        options:
          allow_multiple: true
          require_name: false
    form_with_id = poll_creator.add_id form

    describe "save_poll_to_db", ->
      it "should return the successfully saved object", (done) ->
        poll_creator.save_poll_to_db form_with_id, (err, res) ->
          saved_object = res[0]
          should.not.exist(err)
          expect(saved_object).to.deep.equal(form_with_id)
          done()

          describe "retrieve_poll", ->
            it "should return the queried object", (done) ->
              { url_id } = saved_object
              poll_retriever.retrieve_poll { url_id: url_id }, (err, result) ->
                should.not.exist(err)
                expect(result).to.deep.equal(saved_object)
                done()
