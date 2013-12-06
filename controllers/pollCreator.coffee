Base = require "./base"

class PollCreator extends Base

  # currently only sanitizes data
  process_form = (req, res) ->
    # form = 
    # processed_form = escape_html form
    render_poll req, res
  
  render_poll = (req, res) ->
    res.render "index",
      title: "Form Created!"

exports.module = PollCreator
