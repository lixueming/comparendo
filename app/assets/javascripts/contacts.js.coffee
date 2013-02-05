# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ()->
  $('#contact_form').validate({
    rules: {
      "message[name]": {required: true},
      "message[email]": {required: true, email: true},
      "message[subject]": {required: true, minlength: 5},
      "message[body]": {required: true, minlength: 5}
    }
  })
