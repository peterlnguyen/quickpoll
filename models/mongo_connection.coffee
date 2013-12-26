mongo = require("mongodb").MongoClient
CSON = require "cson"
defaults = CSON.parseFileSync "./models/mongo_defaults.cson"



module.exports = class Mongo

  constructor: (@db_conn, @coll) ->
    # automatically connects to default, can override with manual connection
    @connect()

  # @todo: need to specify which db
  delete_db: (callback) ->
    @coll.drop callback

  create_coll: (coll) ->
    @db.createCollection(coll)

  get_coll: (db, coll) ->
    db.collection(coll)

  # set connection settings to default where not specified by user
  process_options: (options) ->
    if options
      { server, db, collection } = options
    server ?= defaults.server
    db ?= defaults.db
    collection ?= defaults.collection
    { server, db, collection }

  connect: (options) ->
    { server, db, collection } = @process_options options

    console.log "#{server}#{db}"
    url = server + db
    mongo.connect url, (err, db) =>
      @db_conn = db
      @coll = @db_conn.collection(collection)

  insert: (form, callback) ->
    @coll.insert(form, callback)

  find_one: (query, callback) ->
    # findOne() works, but find() returns empty set... strange
    @coll.findOne(query, callback)
