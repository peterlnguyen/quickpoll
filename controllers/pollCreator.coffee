Base = require "./base"

module.exports = class PollCreator extends Base

  @process_form: (req, res) ->
    # form = 
    # processed_form = escape_html form
    @generate_random 5
    @render_poll req, res
  
  @render_poll: (req, res) ->
    res.render "index",
      title: "Form Created!"


