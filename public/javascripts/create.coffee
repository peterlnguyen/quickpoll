$(document).ready ->

  # helper function, almost unnecessary
  extract_fields = (form) ->
    values = {}
    form.each ->
      values[@name] = $(this).val()
    values

  # currently only checks for empty, will fix later
  has_errors = (inputs) ->
    error_flag = false
    for value, key in inputs
      if value is ""
        error_flag = true
    error_flag

  # validates and submits form
  $("#pollSubmit").click ->
    inputs = extract_fields $("#pollForm :input")

    if has_errors inputs
      console.log "input errors!"
    else if has_duplicates ".choices"
      console.log "duplicate errors!"
    else
      console.log "no errors!"
      $("#pollForm").submit()
        
  has_duplicates = (identifier) ->
    choices = {}
    duplicate_flag = false
    $("#{identifier}").each( () ->
      value = $(this).val()
      if choices[value] then duplicate_flag = true
      else choices[value] = "foobar"
    )
    duplicate_flag
     

