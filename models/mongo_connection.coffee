mongo = require("mongodb").MongoClient
CSON = require "cson"
# FIXME: stupid pathing won't load mongo_defaults from cson folder
defaults = CSON.parseFileSync "./models/mongo_defaults.cson"



# all interactions assume a single, consistent db,
# and many possible, volatile collections
module.exports = class Mongo

  constructor: (@db_conn, @coll) ->
    # automatically connects to default, can override with manual connection
    @connect()

  # @todo: need to specify which coll
  delete_coll: (coll, callback) ->
    @db_conn.collection(coll).drop(callback)

  create_coll: (coll, callback) ->
    @db_conn.createCollection(coll, callback)

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
    #console.log "#{server}#{db}"
    url = server + db
    mongo.connect url, (err, db) =>
      if err
        console.error "Mongo connection error: #{err}"
      else
        @db_conn = db
        @coll = @db_conn.collection(collection)

  insert: (form, callback) ->
    @coll.insert(form, callback)

  find_one: (query, callback) ->
    # findOne() works, but find() returns empty set... strange
    @coll.find(query, callback)

  update: (selector, document, callback) ->
    @coll.update(selector, document, callback)
