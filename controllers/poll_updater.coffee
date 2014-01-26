Mongo = require "../models/mongo_connection"
Render = require "../views/render"



module.exports = class PollUpdater

  constructor: ->
    @mongo = new Mongo

  # TODO
  process_update: ({ req, res }) ->
    update = @get_formatted_body { req, res }


  get_formatted_body: ({ req, res }) ->
    poll = req.body
    { url_id } = poll
    # TODO: need to decide body format for sending votes
    choices = @votes_to_list poll

    @count_vote_list { choices: choices, url_id: url_id }, (count_error, count_vote_response) =>
      if count_error
        console.error "Error in count_vote_list: ", count_error
        Render.render_error count_error, res
      else
        @retrieve_poll { url_id: url_id }, (retrieve_error, retrieve_result) ->
          if retrieve_error
            console.log "Retrieve poll error: ", retrieve_error
            Render.render_error retrieve_error, retrieve_result
          else
            { poll_results } = retrieve_result
            Render.render_results poll_results, res

  retrieve_poll: (query, callback) ->
    @mongo.find_one(query, callback)

  # hoping to deprecate
  count_one_vote: ({ choice_number, name, url_id }, callback) ->
    @mongo.update { url_id: url_id, "poll_results.choices.choice_number": choice_number },
      { $push: { "poll_results.choices.$.voter_names": name } }, callback

  # extracts votes from object literal and converts to list for mongo update argument
  votes_to_list: (votes) ->
    choices = []
    for value, key of votes
      if value not in ["name", "url_id"]
        choices.push value
    choices

#  create_update_query: (choice_list) ->
#    poll_results.choices.
#
#  count_vote_list: ({ choices, name, url_id }, callback) ->
#    @mongo.update { url_id: url_id, "poll_results.choices.choice": choices },
#      { $push: { "poll_results.choices.$.voter_names": name } }, callback

  count_vote_list: ({ choices, name, url_id }, callback) ->
    @mongo.update { url_id: url_id, "poll_results.choices.choice": choices },
      { $push: { "poll_results.choices.$.voter_names": name } }, callback









