chai = require "chai"
expect = chai.expect
should = require "should"

PollCreator = require "../../controllers/poll_creator"
poll_creator = new PollCreator



describe "poll_creator unit test", ->

  describe "get_formatted_body", ->

    input =
      body:
        question: "Should we go to Vegas?"
        choices: ["Yes", "No", "Maybe"]
        allow_multiple: "on"
        # require_name intentionally omitted
        
    expected =
      poll_query:
        question: "Should we go to Vegas?"
        choices: ["Yes", "No", "Maybe"]
        options:
          allow_multiple: true
          require_name: false
      poll_results:
        choices: [
          {
            choice_number: 0
            choice: "Yes"
            voter_names: []
            num_votes: 0
          },
          {
            choice_number: 1
            choice: "No"
            voter_names: []
            num_votes: 0
          },
          {
            choice_number: 2
            choice: "Maybe"
            voter_names: []
            num_votes: 0
          }
        ]

    it "should extrapolate and format form data", ->
      result = poll_creator.get_formatted_body input
      expect(result).to.deep.equal(expected)


  describe "add_id", ->
  
    input =
      question: "Should we go to Vegas?"

    it "should append a url_id field to the top level of object", ->
      result = poll_creator.add_id input
      { url_id } = result
      url_id.should.exist
      # minimum length lowers chance of collision
      expect(url_id).to.have.length.above(10)


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
              poll_creator.retrieve_poll { url_id: url_id }, (err, result) ->
                should.not.exist(err)
                expect(result).to.deep.equal(saved_object)
                done()

  # @todo
  describe "render_poll", ->

  describe "process_form", ->

  describe "retrieve_and_render", ->
