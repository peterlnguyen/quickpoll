$(document).ready ->

  current_choice = 5
  current_id = "#choice5"

  bind_append = (identifier) ->
    $(identifier).keyup ->
      bind_next()

  bind_next = ->
    $(current_id).unbind()
    current_choice++
    current_id = "#choice" + current_choice
    append_choice()
    console.log "now current choice: ", current_choice
    bind_append current_id
  
  append_choice = ->
    $("#choice-list").append('
      <div>
        <label> Choice ' + current_choice + ':</label>
        <input type="text" name="choices" id="choice' + current_choice + '" class="choices">
      </div>
    ')

  bind_append(current_id)

  # TODO: remove the last choice if (1) choice is erased to a blank (2) choice moves out of focus (3) choice is last choice (i.e. current_choicei)

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

     

