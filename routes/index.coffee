PollCreator = require "../controllers/poll_creator"
poll_creator = new PollCreator
PollUpdater = require "../controllers/poll_updater"
poll_updater = new PollUpdater

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
         
