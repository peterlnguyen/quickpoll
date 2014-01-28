Base = require "./base"
Render = require "../views/render"
Mongo = require "../models/mongo_connection"



module.exports = class PollRetriever

  constructor: ->
    @mongo = new Mongo

  retrieve_and_render_query: ({ url_id, res }) ->

    @retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_result) =>
      if retrieve_error
        Render.render_error retrieve_error, res
      else
        { poll_query } = retrieve_result
        Render.render_poll { poll_query, url_id }, res

  retrieve_and_render_result: ({ url_id, res }) ->

    @retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_result) ->
      if retrieve_error
        Render.render_error retrieve_error, res
      else
        { poll_results } = retrieve_result
        Render.render_results { poll_results, url_id }, res

  retrieve_poll: (query, callback) ->
    @mongo.find_one(query, callback)

