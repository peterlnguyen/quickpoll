poll_creator = require "../controllers/poll_creator"
#
# * GET home page.
# 

exports.index = (req, res) ->
  res.render "create",
    title: "Express"

exports.create_form = (req, res) ->
  poll_creator.process_form {req: req, res: res}
