pollCreator = require "../controllers/pollCreator"
#
# * GET home page.
# 

exports.index = (req, res) ->
  res.render "create",
    title: "Express"

exports.create_form = (req, res) ->
  pollCreator.process_form {req: req, res: res}
