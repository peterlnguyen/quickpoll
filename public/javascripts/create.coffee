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
    console.log "error?", error_flag
    error_flag

  # validates and submits form
  $("#pollSubmit").click ->
    inputs = extract_fields $("#pollForm :input")
    if not has_errors inputs
      $("#pollForm").submit()
        

     

