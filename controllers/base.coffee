


# this class provides utility functions,
# logging, infrastructure, etc.
module.exports = class Base

  # sanitize form data
  @escape_html: (text) ->
    text
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;")

  # code copied from http://stackoverflow.com/a/1349426
  @generate_random: (length) ->
    text = ""
    possible = "abcdefghijklmnopqrstuvwxyz0123456789"
    while length-- > 0
      text += possible.charAt(Math.floor(Math.random() * possible.length))
    text
