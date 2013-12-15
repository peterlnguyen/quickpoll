mongo = require("mongodb").MongoClient

defaults =
  server: "mongodb://127.0.0.1:27017/"
  db: "polls"
  collection: "polls"


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

  @process_options: (options) ->
    # set connection settings to default where not specified by user
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
      console.log "err:", err
      @db = db
      # console.log "db:", db
      @coll = @db.collection(collection)
      console.log "coll: ", @coll

  @insert: (form, callback) ->
    @coll.insert(form, callback)

  @find: (query, callback) ->
    @coll.find(query, callback)



