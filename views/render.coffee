


module.exports = class Render

  constructor: ->

  @render_error: (err, res) ->
    res.render "error",
      title: err

  @render_poll: (poll, res) ->
    res.render "index",
      title: "Poll Rendered, Baby!"
