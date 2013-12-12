mongo = require("mongodb").MongoClient
coll = null
site = "mongodb://127.0.0.1:2707/polls"

module.exports = class Mongo

  @coll = null

  @constructor: ->
    mongo.connect polls, (err, db) ->
      @coll = db.collection "polls"
  
  @insert: (form, callback) ->
    coll.insert(form, callback)

  @find: (query, callback) ->
    coll.find(query, callback)



