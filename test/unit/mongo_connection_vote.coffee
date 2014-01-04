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
          field: "non-updated"

      mongo.insert form, (insert_error, insert_response) ->
        should.not.exist(insert_error)
        console.log "insert response: ", insert_response

        it "should retrieve the inserted document", ->
        mongo.find_one { rand_id: rand_id }, (find_error, find_response) ->
          console.log "find_response: ", find_response
          should.not.exist(find_error)
          expect(find_response).to.deep.equal(insert_response[0])
          
          it "should update the retrieved document", ->
            mongo.update { rand_id: rand_id }, { $set: { target: { field: "updated" } } }, (update_error, update_response) ->
              console.log "update response: ", update_response
              update_response.should.equal(1)

              it "should retrieve updated document", ->
                mongo.find_one { rand_id: rand_id }, (updated_error, updated_response) ->
                  console.log "find_response: ", updated_response
                  should.not.exist(updated_error)
                  updated_response.field.target.should.equal("updated")
                  done()

