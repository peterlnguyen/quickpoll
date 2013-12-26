chai = require "chai"
should = require "should"
expect = chai.expect

Mongo = require "../../models/mongo_connection"
mongo = new Mongo

CSON = require "cson"
defaults = CSON.parseFileSync "./models/mongo_defaults.cson"



describe "mongo_connection unit test", ->

  describe "process_options", ->
    { server, db, collection } = defaults
    it "should fill in all defaults for a blank input", ->
      options = mongo.process_options()
      expect(options).to.deep.equal(defaults)

    it "should have custom server, default db, and default collection", ->
      custom_server = "custom-server"
      options = mongo.process_options { server: custom_server }
      options.server.should.equal custom_server
      options.db.should.equal db
      options.collection.should.equal collection

    it "should have default server, custom db, and default collection", ->
      custom_db = "custom-db"
      options = mongo.process_options { db: custom_db }
      options.server.should.equal server
      options.db.should.equal custom_db
      options.collection.should.equal collection

    it "should have default server, default db, and custom collection", ->
      custom_collection = "custom-collection"
      options = mongo.process_options { collection: custom_collection }
      options.server.should.equal server
      options.db.should.equal db
      options.collection.should.equal custom_collection

  describe "connect and interact with db", ->
    it "should connect to the default settings and instantiate db_connection and collection", (done) ->
      mongo.connect()
      {db_conn, coll} = mongo

      db_conn.should.exist
      coll.should.exist
      done()

      describe "create and delete collection", ->

        describe "create collection", ->
          it "should return the successfully created collection", (done) ->
            mongo.create_coll "test-coll", (err, res) ->
              should.not.exist(err)
              should.exist(res)
              done()

              describe "delete collection", ->
                describe "for existing collection", ->
                  it "should return true for successfully deleted collection", (done) ->
                    mongo.delete_coll "test-coll", (err, res) ->
                      should.not.exist(err)
                      should.exist(res)
                      res.should.be.true
                      done()

                describe "for nonexistent collection", ->
                  it "should return false for nonexistent collection", (done) ->
                    mongo.delete_coll "nonexistent-coll", (err, res) ->
                      should.exist(err)
                      should.exist(res)
                      res.should.be.false
                      done()














