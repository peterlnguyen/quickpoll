
#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "create",
    title: "Express"

exports.create_form = (req, res) ->
  res.render "index",
    title: "Form Created!"
