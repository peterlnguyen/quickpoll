chai = require "chai"
expect = chai.expect
Poll_Creator = require "../../controllers/poll_creator"
poll_creator = new Poll_Creator

describe "Poll_Creator unit test (no database interaction)", ->

  describe "get_formatted_body", ->

    input =
      body:
        question: "Should we go to Vegas?"
        choice1: "Yes"
        choice2: "No"
        choice3: "Maybe"
        allow_multiple: "on"
        # require_name intentionally omitted
        
    expected =
      question: "Should we go to Vegas?"
      choices:
        choice1: "Yes"
        choice2: "No"
        choice3: "Maybe"
      options:
        allow_multiple: true
        require_name: false

    it "should extrapolate and format form data", ->
      result = poll_creator.get_formatted_body input
      expect(result).to.deep.equal(expected)


  describe "add_id", ->
  
    input =
      question: "Should we go to Vegas?"

    it "should append a url_id field to the top level of object", ->
      result = poll_creator.add_id input
      {url_id} = result
      url_id.should.exist
      # minimum length lowers chance of collision
      expect(url_id).to.have.length.above(10)
    

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
          console.log "hello world"
          done()

          describe "retrieve_poll", ->
            it "should return the queried object", (done) ->
              console.log "fizz buzz"
              {url_id} = saved_object
              poll_creator.retrieve_poll { url_id: url_id }, (err, result) ->
                expect(result).to.deep.equal(saved_object)
                done()

