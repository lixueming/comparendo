# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# create namespace
ga = window.ga || {}
ga.user = ga.user || {}
ga.user.hooks = ga.user.hooks || {}
window.ga = ga

ga.user.hooks.signup = ()->
  $('#user_signup_form').validate({
    rules: {
      "user[name]": {required: true},
      "user[email]": {required: true, email: true, remote: "/users/check_email"},
      "user[password]": {required: true, minlength: 6},
      "user[password_confirmation]": {required: true, equalTo: "#user_password"}
    }
    messages: {
      "user[email]": {remote: "Email already exists"}
    }
  })

ga.user.hooks.editProfile = ()->
  $("#user_edit_profile_form").validate({
    rules: {
      "user[name]": {required: true}
    }
  })

$(document).ready ()->
  ga.user.hooks.signup()
  ga.user.hooks.editProfile()