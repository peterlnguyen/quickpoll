Mongo = require "../models/mongo_connection"
Render = require "../views/render"



module.exports = class PollUpdater

  constructor: ->
    @mongo = new Mongo

  # TODO
  process_update: ({ req, res }) ->

    update = @get_formatted_body { req, res }

#    @count_one_vote choice_number:
#      name:

  votes_to_list: (votes) ->
    choices = []
    for value, key of votes
      if value not in ["name", "url_id"]
        choices.push value
    choices

  get_formatted_body: ({ req, res }) ->
    poll = req.body
    {url_id} = poll
    # TODO: need to decide body format for sending votes
    # TODO: @count_many_votes()
    console.log "poll: ", poll
    choices = @votes_to_list poll
    console.log "req.bod: ", req.body

    @count_vote_list { choices: choices, url_id: url_id }, (error, count_vote_response) =>
      if error
        console.error "Error in count_vote_list: ", error
        Render.render_error error, res
      else
        console.log "done counting votes, no error.  callback: ", count_vote_response
        @retrieve_poll { url_id: url_id }, (err, retrieve_result) =>
          if err
            console.log "Retrieve poll error: #{err}"
            Render.render_error err, retrieve_result
          else
            Render.render_results retrieve_result, res

  retrieve_poll: (query, callback) ->
    @mongo.find_one(query, callback)

  count_one_vote: ({ choice_number, name, url_id }, callback) ->
    @mongo.update { url_id: url_id, "poll_results.choices.choice_number": choice_number },
      { $push: { "poll_results.choices.$.voter_names": name } }, callback

  count_vote_list: ({ choices, name, url_id }, callback) ->
    @mongo.update { url_id: url_id, "poll_results.choices.choice": choices },
      { $push: { "poll_results.choices.$.voter_names": name } }, callback

  # TODO: need to check for all form items EXCEPT "name" and "url_id", rest are choices
  count_many_votes: ({ votes_list, url_id }, { req, res }) ->
    # do nothing

