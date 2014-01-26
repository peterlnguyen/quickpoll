Mongo = require "../models/mongo_connection"
Render = require "../views/render"



module.exports = class PollUpdater

  constructor: ->
    @mongo = new Mongo

  # TODO: separate nested callbacks
  process_update: ({ req, res }) ->
    poll = req.body
    console.log poll
    { url_id, name } = poll
    choices = @votes_to_list poll
    push_query = @create_update_query choices, name

    # FIXME: need to modularize this, in case name is not required
    @count_vote_list { push_query: push_query, url_id: url_id },
      (count_error, count_vote_response) =>
        if count_error
          console.error "Error in count_vote_list: ", count_error
          Render.render_error count_error, res
        else
          @retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_result) ->
            if retrieve_error
              console.log "Retrieve poll error: ", retrieve_error
              Render.render_error retrieve_error, res
            else
              { poll_results } = retrieve_result
              Render.render_results poll_results, res

  retrieve_poll: (query, callback) ->
    @mongo.find_one(query, callback)

  # extracts votes from object literal and converts to list for mongo update argument
  votes_to_list: (votes) ->
    choices = []
    for value, key of votes
      if value not in ["name", "url_id"]
        choices.push value
    choices

  create_update_query: (choice_list, name) ->
    # FIXME: placeholder
    if !name then name = "Bob"
    push_query = {}
    for choice in choice_list
      push_query["poll_results.choices.#{choice}.voter_names"] = name
    push_query

  count_vote_list: ({ push_query, url_id }, callback) ->
    @mongo.update { url_id: url_id },
      { $push: push_query }, callback



