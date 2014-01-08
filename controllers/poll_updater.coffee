Mongo = require "../models/mongo_connection"
Render = require "../views/render"



module.exports = class PollUpdater

  constructor: ->
    @mongo = new Mongo
    # do nothing

  count_one_vote: (choice, name) ->

  count_many_votes: (votes_list) ->


