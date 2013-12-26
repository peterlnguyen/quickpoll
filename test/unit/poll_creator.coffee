chai = require "chai"
expect = chai.expect
poll_creator = require "../../controllers/poll_creator"

describe "poll_creator unit test (no database interaction)", ->

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

    describe "save_poll_to_db", ->

      form =
        question: "Should we go to Vegas?"
        choices:
          choice1: "Yes"
          choice2: "No"
          choice3: "Maybe"
        options:
          allow_multiple: true
          require_name: false

      describe "something", ->
        it "should something", ->
          poll_creator.save_poll_to_db form, (err, res) ->
            saved_object = res[0]
            expect(saved_object).to.deep.equal(form)

            describe "retrieve_poll", ->
              it "should return the queried object", (done) ->
                {url_id} = saved_object
                poll_creator.retrieve_poll { url_id: url_id }, (err, res) ->
                  console.log form
                  console.log saved_object
                  console.log form
                  expect(res).to.deep.equal(form)
                  done()


