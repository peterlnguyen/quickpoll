mongo = require("mongodb").MongoClient

coll = null
default_server = "mongodb://127.0.0.1:2707/polls"


module.exports = class Mongo

  @coll = null

  @connect: (host) ->
    host ?= default_server
    mongo.connect polls, (err, db) ->
      @coll = db.collection "polls"
  
  @insert: (form, callback) ->
    coll.insert(form, callback)

  @find: (query, callback) ->
    coll.find(query, callback)



