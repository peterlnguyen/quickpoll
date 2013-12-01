Base = require "./base"

class PollCreator extends Base

  # currently only sanitizes data
  process_form = (req, res) ->
    # form = 
    processed_form = escape_html form


exports.module = PollCreator
