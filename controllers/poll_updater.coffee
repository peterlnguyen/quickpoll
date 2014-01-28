PollRetriever = require "./poll_retriever"
Mongo = require "../models/mongo_connection"
Render = require "../views/render"



module.exports = class PollUpdater

  constructor: ->
    @mongo = new Mongo
    @poll_retriever = new PollRetriever
    @votes_list_exclusion = ["name", "url_id"]

  process_update: ({ req, res }) ->
    { update_query, url_id } = @get_query_params req

    @count_vote_list { update_query, url_id },
      (count_error, count_vote_response) =>
        if count_error
          console.error "Error in count_vote_list: ", count_error
          Render.render_error count_error, res
        else
          @poll_retriever.retrieve_and_render_result { url_id, res }

  # brings together necessary data to update the vote
  get_query_params: (req) ->
    poll = req.body
    { url_id, name } = poll
    choices = @votes_to_list poll

    update_query  = {}
    if name
      update_query["$push"] = @generate_push_query choices, name
    update_query["$inc"] = @generate_increment_count_query choices, name

    { update_query, url_id }

  # extracts votes from object literal and converts to list for mongo update argument
  votes_to_list: (votes) ->
    choices = []
    for value, key of votes
      if value not in @votes_list_exclusion
        choices.push value
    choices

  generate_increment_count_query: (choice_list, name) ->
    increment_count_query = {}
    for choice in choice_list
      increment_count_query["poll_results.choices.#{choice}.count"] = 1
    increment_count_query
  
  # generates it by iterating through choice_list
  generate_push_query: (choice_list, name) ->
    push_query = {}
    for choice in choice_list
      push_query["poll_results.choices.#{choice}.voter_names"] = name
    push_query

  count_vote_list: ({ update_query, url_id }, callback) ->
    @mongo.update { url_id: url_id },
      update_query, callback



