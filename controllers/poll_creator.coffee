Base = require "./base"
PollRetriever = require "./poll_retriever"
Render = require "../views/render"
Mongo = require "../models/mongo_connection"



module.exports = class PollCreator extends Base

  constructor: ->
    @mongo = new Mongo
    @poll_retriever = new PollRetriever
    super()

  # equivalent to your "main" function in creating a poll
  process_form: ({ req, res }) ->
    form = @get_formatted_body req
    form_with_id = @add_id form

    # attempts to save, retrieve, and render poll; throws err otherwise
    @save_poll_to_db form_with_id, (err, save_res) =>
      if err
        console.error "Save poll error: #{err}"
        Render.render_error err, save_res
      else
        url_id = save_res[0].url_id
        @poll_retriever.retrieve_and_render_query { url_id, res }

  add_id: (form) ->
    form_id = @generate_random 20
    form.url_id = form_id
    form

  # TODO: unit test
  # converts a list of choices into object containing results for each choice
  create_poll_results_object: (form_choices) ->
    count = 0
    poll_results = {}
    choices = {}
    for choice in form_choices
      choices[choice] =
        choice_number: count++
        choice: choice
        voter_names: []
        count: 0
    poll_results.choices = choices
    poll_results

  get_formatted_body: (req) ->
    body = req.body
    allow_multiple = if body.allow_multiple then true else false
    require_name = if body.require_name then true else false

    poll =
      poll_query:
        question: body.question
        choices: body.choices
        options:
          allow_multiple: allow_multiple
          require_name: require_name
    poll.poll_results = @create_poll_results_object body.choices
    poll

  save_poll_to_db: (form, callback) ->
    @mongo.insert(form, callback)
