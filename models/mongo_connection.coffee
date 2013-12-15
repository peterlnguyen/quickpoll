mongo = require("mongodb").MongoClient
CSON = require "cson"
defaults = CSON.parseFileSync "./models/mongo_defaults.cson"



module.exports = class Mongo

  db_conn = null
  coll = null

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
    mongo.connect url, (err, db) =>
      db_conn = db
      #console.log db_conn.collection("polls")
      # count returns correct amount, perhaps my query is wrong
      db_conn.collection("polls").count (err, count) =>
        console.log "#{err}, #{count}"
      db_conn.collection("polls").find (err, res) =>
        console.log "res connect: ", JSON.stringify(res)
      coll = db_conn.collection(collection)

  @insert: (form, callback) ->
    coll.insert(form, callback)

  @find: (query, callback) ->
    console.log "query: ", query
    #console.log "find: #{coll}"
    coll.find(query, callback)



