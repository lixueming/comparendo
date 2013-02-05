# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# create namespace
ga = window.ga || {}
ga.offer = ga.offer || {}
ga.offer.hooks = ga.offer.hooks || {}
window.ga = ga

ga.offer.validDate = ()->
  start_month = parseInt($('#new_offer_form #project_start_date_month').attr('value'))
  start_year = parseInt($('#new_offer_form #project_start_date_year').attr('value'))
  end_month = parseInt($('#new_offer_form #project_end_date_month').attr('value'))
  end_year = parseInt($('#new_offer_form #project_end_date_year').attr('value'))

  if start_year > end_year or (start_year == end_year and start_month > end_month)
    return false

  return true

ga.offer.validateDate = ()->
  control_group = $('#new_offer_form #project_end_date_month').closest('.control-group')
  control_group.find('label[for=end_date]').remove()

  if ga.offer.validDate()
    control_group.removeClass('error')
    return true
  else
    control_group = $('#new_offer_form #project_end_date_month').closest('.control-group')
    control_group.addClass('error')
    control_group.append($('<label for="end_date" generated="true" class="error">' + I18n.t('errors.messages.offer.invalid_date') + '</label>'))

    return false

ga.offer.hooks.newOffer = ()->
  $('#new_offer_form').validate({
    onkeyup: false,
    highlight: (el)-> $(el).closest('.control-group').addClass('error')
    unhighlight: (el)-> $(el).closest('.control-group').removeClass('error')
    rules: {
      "project[budget]": {
        required: true
        number: true
      }
    },
    messages: {
      'project[budget]': I18n.t('errors.messages.number')
    }
  })

  # validate date start date <= end date
  $('#new_offer_form').submit ()->
    return ga.offer.validateDate()
  $('#new_offer_form #project_start_date_month').change ()-> ga.offer.validateDate()
  $('#new_offer_form #project_start_date_year').change ()-> ga.offer.validateDate()
  $('#new_offer_form #project_end_date_month').change ()-> ga.offer.validateDate()
  $('#new_offer_form #project_end_date_year').change ()-> ga.offer.validateDate()

$(document).ready ()->
  ga.offer.hooks.newOffer()
