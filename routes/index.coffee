PollCreator = require "../controllers/poll_creator"
poll_creator = new PollCreator

#
# * GET home page.
#

exports.index = (req, res) ->
  res.render "create",
    title: "Create Page, Baby"

exports.create_form = (req, res) ->
  poll_creator.process_form { req: req, res: res }
