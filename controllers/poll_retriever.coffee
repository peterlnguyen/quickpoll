Base = require "./base"
Render = require "../views/render"
Mongo = require "../models/mongo_connection"



module.exports = class PollRetriever

  constructor: ->
    @mongo = new Mongo

  retrieve_and_render_query: ({ url_id }, { res }) ->

    @retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_res) =>
      if retrieve_error
        console.error "Retrieve poll error: #{retrieve_error}"
        Render.render_error retrieve_error, retrieve_res
      else
        { poll_query } = retrieve_res
        console.log "retrieve res: ", retrieve_res
        Render.render_poll { poll_query, url_id }, res

  retrieve_and_render_result: ({ url_id }, { res }) ->

    @retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_result) ->
      if retrieve_error
        console.log "Retrieve poll error: ", retrieve_error
        Render.render_error retrieve_error, res
      else
        console.log "poll results: ", retrieve_result
        { poll_results } = retrieve_result
        Render.render_results { poll_results, url_id }, res

  retrieve_poll: (query, callback) ->
    @mongo.find_one(query, callback)

