Base = require "./base"
Render = require "../views/render"
Mongo = require "../models/mongo_connection"



module.exports = class PollCreator extends Base

  constructor: ->
    @mongo = new Mongo
    super()

  # equivalent to your "main" function in creating a poll
  process_form: (req_res) ->
    {req, res} = req_res
    form = @get_formatted_body req
    form_with_id = @add_id form

    # attempts to save, retrieve, and render poll; throws err otherwise
    @save_poll_to_db form_with_id, (err, save_res) =>
      if err
        console.error "Save poll error: #{err}"
        Render.render_error err, save_res
      else
        @retrieve_and_render save_res, req_res

  retrieve_and_render: (retrieve_query, req_res) ->
    {req, res} = req_res
    # immediately parse custom url_id to retrieve poll
    url_id = retrieve_query[0].url_id

    @retrieve_poll { url_id: url_id }, (err, retrieve_res) =>
      if err
        console.error "Retrieve poll error: #{err}"
        Render.render_error err, retrieve_res
      else
        @render_poll req_res, retrieve_res

  render_poll: (req_res, poll) ->
    {req, res} = req_res
    Render.render_poll "poll", res

  add_id: (form) ->
    form_id = @generate_random 15
    form.url_id = form_id
    form

  # TODO: unit test
  # converts a list of choices into object containing results for each choice
  generate_poll_results: (form_choices) ->
    count = 0
    poll_results = {}
    choices = []
    for key, value of form_choices
      choices.push
        choice_number: ++count
        choice: value
        voter_names: []
        num_votes: 0
    poll_results.choices = choices
    poll_results

  get_formatted_body: (req) ->
    body = req.body
    allow_multiple = if body.allow_multiple then true else false
    require_name = if body.require_name then true else false

    poll =
      poll_query:
        question: body.question
        choices:
          choice1: body.choice1
          choice2: body.choice2
          choice3: body.choice3
        options:
          allow_multiple: allow_multiple
          require_name: require_name
    # FIXME: pass choices as a proper list
    poll.poll_results = @generate_poll_results
      choice1: body.choice1
      choice2: body.choice2
      choice3: body.choice3
    poll

  save_poll_to_db: (form, callback) ->
    @mongo.insert(form, callback)

  retrieve_poll: (query, callback) ->
    @mongo.find_one(query, callback)

