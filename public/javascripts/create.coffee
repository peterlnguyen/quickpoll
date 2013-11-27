$(document).ready ->

  extract_fields = (form) ->
    values = {}
    form.each ->
      values[@name] = $(this).val()
    console.log values
    values

  is_valid = (inputs) ->
    error_flag = false
    for value, key in inputs 
      if value is ""


  $("#pollSubmit").click ->
    inputs = extract_fields $("#pollForm :input")
    if is_valid inputs
      true

     

