# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  # Create a record
  $(".record-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      #$(xhr.responseText).hide().insertBefore($("#rec_area")).show('slow')
      $(xhr.responseText).hide().insertAfter($(this)).show('slow')

  # Delete a record 
  $(document) 
    .on "ajax:beforeSend", ".record", -> 
      $(this).fadeTo('fast', 0.5) 
    .on "ajax:success", ".record", -> 
      $(this).hide('fast') 
    .on "ajax:error", ".record", -> 
      $(this).fadeTo('fast', 1)      