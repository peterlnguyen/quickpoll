chai = require "chai"
should = require "should"
expect = chai.expect

Mongo = require "../../models/mongo_connection"
mongo = new Mongo

CSON = require "cson"
defaults = CSON.parseFileSync "./models/mongo_defaults.cson"



describe "mongo_connection unit test for voting", ->

  describe "update", ->
    { server, db, collection } = defaults
    it "should insert the document without error", (done) ->
      rand_id = Math.random()*10
      form =
        rand_id: rand_id
        target:
          fields: [ "fish", "dog", "cat" ]

      mongo.insert form, (insert_error, insert_response) ->
        should.not.exist(insert_error)
        done()

        describe "find_one", ->
          it "should retrieve the inserted document", (done) ->
            mongo.find_one { rand_id: rand_id }, (find_error, find_response) ->
              should.not.exist(find_error)
              expect(find_response).to.deep.equal(insert_response[0])
              done()
              
              describe "update", ->
                it "should update the retrieved document", (done) ->
                  mongo.update { rand_id: rand_id },
                    { $push: { "target.fields": "monkey" } },
                    (update_error, update_response) ->
                      should.not.exist(update_error)
                      update_response.should.equal(1)
                      done()

                      describe "find_one", ->
                        it "should retrieve updated document", (done) ->
                          mongo.find_one { rand_id: rand_id }, (updated_error, updated_response) ->
                            should.not.exist(updated_error)
                            updated_response.target.fields.should.contain("monkey")
                            done()
      
