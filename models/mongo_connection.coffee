mongo = require("mongodb").MongoClient
CSON = require "cson"
defaults = CSON.parseFileSync "./models/mongo_defaults.cson"



module.exports = class Mongo

  @db = null
  @coll = null

  # @todo: need to specify which db
  @delete_db: (callback) ->
    @coll.drop callback

  @create_coll: (coll) ->
    @db.createCollection(coll)

  @get_coll: (db, coll) ->
    db.collection(coll)

  # set connection settings to default where not specified by user
  @process_options: (options) ->
    if options
      { server, db, collection } = options
    server ?= defaults.server
    db ?= defaults.db
    collection ?= defaults.collection
    { server, db, collection }

  @connect: (options) ->
    { server, db, collection } = @process_options options

    console.log "#{server}#{db}"
    url = server + db
    mongo.connect url, (err, db) ->
      #console.log "err:", err
      @db = db
      # console.log "db:", db
      @coll = @db.collection(collection)
      #console.log "coll: ", @coll

  @insert: (form, callback) ->
    console.log "coll here: ", @coll
    console.log "db: ", @db
    @coll.insert(form, callback)

  @find: (query, callback) ->
    @coll.find(query, callback)



