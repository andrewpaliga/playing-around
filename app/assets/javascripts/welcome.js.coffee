# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.append_images = (category_id, page)->
  $.ajax(url: "/categories/"+category_id+"/pages/"+page, type: "GET", dataType: "html").done (html) ->
    $('#images-container').append html

    
