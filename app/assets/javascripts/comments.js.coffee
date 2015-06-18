# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('.edit').click (event) ->
    event.preventDefault()
    $(this).closest('tr').next().slideToggle() //find("#<%=raw('\"edit_comment_#{@comment.id}\"')%>").slideToggle()
    return
  return
