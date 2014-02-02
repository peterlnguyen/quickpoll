


module.exports = class Render

  @render_error: (err, res) ->
    res.render "error",
      title: err
  
  @render_poll: ({ poll_query, url_id }, res) ->
    res.render "poll",
      title: "Poll Rendered!"
      poll: poll_query
      url_id: url_id

  @render_results: ({ poll_query, poll_results, url_id }, res) ->
    res.render "results",
      title: "Poll Results"
      question: poll_query.question
      results: poll_results
      url_id: url_id

  @render_index: (res) ->
    res.render "index",
      title: "Here's the index!"
