


module.exports = class Render

  @render_error: (err, res) ->
    res.render "error",
      title: err
  
  @render_poll: (poll, res) ->
    console.log "poll to render: ", poll
    res.render "poll",
      title: "Poll Rendered!"
      # FIXME: temporary fix to remove the ids and other sensitive data
      poll: poll.poll_query
      url_id: poll.url_id

  @render_results: (results, res) ->
    res.render "results",
      title: "Poll Results"
      results: results

  @render_index: (res) ->
    res.render "index",
      title: "Here's the index!"
