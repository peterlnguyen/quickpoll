


module.exports = class Render

  @render_error: (err, res) ->
    res.render "error",
      title: err
  
  @render_poll: (poll, res) ->
    # FIXME: temporary fix to remove the ids and other sensitive data
    res.render "poll",
      title: "Poll Rendered!"
      poll: poll.poll_query
      url_id: poll.url_id

  @render_results: (results, res) ->
    res.render "results",
      title: "Poll Results"
      results: results

  @render_index: (res) ->
    res.render "index",
      title: "Here's the index!"
