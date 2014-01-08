Mongo = require "../models/mongo_connection"
Render = require "../views/render"



module.exports = class PollUpdater

  constructor: ->
    @mongo = new Mongo

  # TODO
  process_update: (req_res) ->
    { req, res } = req_res

    update = @get_formatted_body req

  get_formatted_body: (req) ->
    body = req.body
    # TODO: need to decide body format for sending votes

  count_one_vote: ( { choice_number, name, url_id }, req_res) ->
    { req, res } = req_res

    # TODO: make sure pushing to a particular array works
    @mongo.update { url_id: url_id, "poll_results.choices.choice_number": choice_number },
      { $push: { "poll_results.choices.$.voter_names": name } },
      (error, response) ->
        if error
          console.log "Single vote update error: #{error}"
          Render.render_error error, res
        else
          # fetch and display poll

  # TODO
  count_many_votes: ({ votes_list, url_id }, req_res) ->
    { req, res } = req_res

