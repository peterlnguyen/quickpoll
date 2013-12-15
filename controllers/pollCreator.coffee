Base = require "./base"
mongo = require "../models/mongo_connection"
mongo.connect()

module.exports = class PollCreator extends Base

  @process_form: (req_res) ->
    {req, res} = req_res
    form = @get_formatted_body req
    form_with_id = @add_id form

    # attempts to save, retrieve, and render poll; throws err otherwise
    @save_poll_to_db form_with_id, (err, save_res) ->
      if err
        @render_error err, res
      else
        @retrieve_and_render save_res, req_res

  @add_id: (form) ->
    form_id = @generate_random 5
    form.id = form_id
    form

  @retrieve_and_render = (retrieve_query, req_res) ->
    {req, res} = req_res
    @retrieve_poll retrieve_query, (err, retrieve_res) ->
      if err
        @render_error err, retrieve_res
      else
        poll = retrieve_res[0]
        @render_poll req_res, poll
 

  @get_formatted_body: (req) ->
    body = req.body
    allow_multiple = if body.allowMultiple then true else false
    require_name = if body.requireName then true else false

    params =
      question: body.question
      choices:
        choice1: body.choice1
        choice2: body.choice2
        choice3: body.choice3
      options:
        allow_multiple: allow_multiple
        require_name: require_name
    params

  @render_poll: (req_res, poll) ->
    {req, res} = req_res
    res.render "index",
      title: "Poll Rendered!"

  @save_poll_to_db = (form, callback) ->
    mongo.insert(form, callback)

  @retrieve_poll = (query, callback) ->
    mongo.find(query, callback)
