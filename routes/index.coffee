PollCreator = require "../controllers/poll_creator"
poll_creator = new PollCreator
PollUpdater = require "../controllers/poll_updater"
poll_updater = new PollUpdater
PollRetriever = require "../controllers/poll_retriever"
poll_retriever = new PollRetriever

#
# * GET home page.
#

exports.index = (req, res) ->
  res.render "create",
    title: "Create Page, Baby!"

exports.create_form = (req, res) ->
  poll_creator.process_form { req: req, res: res }

exports.submit_vote = (req, res) ->
  poll_updater.process_update { req: req, res: res }

exports.render_poll = (req, res) ->
  { url_id } = req.route.params
  { url_id } = req.body if url_id is "submitVote"
  poll_retriever.retrieve_and_render_query { url_id, res }
