# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# create namespace
ga = window.ga || {}
ga.company = ga.company || {}
ga.company.hooks = ga.company.hooks || {}
window.ga = ga

ga.company.hooks.newCompany = ()->
  $('#company_add_form').validate({
    onkeyup: false,
    highlight: (el)-> $(el).closest('.control-group').addClass('error')
    unhighlight: (el)-> $(el).closest('.control-group').removeClass('error')
    rules: {
      "company[name]": {
        required: true,
        unique: ()->
          company_name_array = []
          $.ajax '/company/company_names',
            type: 'get'
            async: false
            dataType: 'json'
            success: (response) ->
              company_name_array = $.map(response, (el, indx) -> el.toLowerCase())
          if $('#company_name').attr('original-name')
            _.without company_name_array, $('#company_name').attr('original-name').toLowerCase()
          else
            company_name_array
      },
      "company[region_id]": {
        non_zero: true
      }
    },
    messages: {
      'company[name]': {
        required: I18n.t('fields.company_name') + ' ' + I18n.t('errors.messages.blank'),
        unique: I18n.t('errors.messages.company.company_name_must_be_unique')
      }
      'company[region_id]': I18n.t('errors.messages.company.company_location_must_not_be_default')
    }
  })

  $('#company_add2_form').validate({
    onkeyup: false,
    highlight: (el)-> $(el).closest('.control-group').addClass('error')
    unhighlight: (el)-> $(el).closest('.control-group').removeClass('error')
    rules: {
      "company[contact_person]": {required: true}
      "company[address]": {required: true}
      "company[postal_code]": {required: true, digits: true, rangelength: [4, 4]}
      "company[city]": {required: true}
      "company[phone_numbers][]": {required: true, phoneSwiss: true}
      "company[email]": {email: true}
      "company[websites][]": {urlLoose: true}
      "company[description]": {required: true, maxWords: 100}
    }
    messages: {
      "company[contact_person]": {
        required: I18n.t('fields.contact_person') + ' ' + I18n.t('errors.messages.blank')
      }
      "company[address]": {
        required: I18n.t('fields.address') + ' ' + I18n.t('errors.messages.blank')
      }
      "company[postal_code]": {
        required: I18n.t('fields.postal_code') + ' ' + I18n.t('errors.messages.blank')
        digits: I18n.t('errors.messages.4_digit_postal_code')
        rangelength: I18n.t('errors.messages.4_digit_postal_code')
      }
      "company[city]": {
        required: I18n.t('fields.city') + ' ' + I18n.t('errors.messages.blank')
      }
      "company[phone_numbers][]": {
        required: I18n.t('fields.phone_number') + ' ' + I18n.t('errors.messages.blank')
        phoneSwiss: I18n.t('errors.messages.phone_swiss')
      }
      "company[email]": {
        email: I18n.t('errors.messages.email')
      }
      "company[websites][]": {
        urlLoose: I18n.t('errors.messages.url')
      }
      "company[description]": {
        required: I18n.t('fields.description') + ' ' + I18n.t('errors.messages.blank')
        maxWords: I18n.t('fields.description') + ' ' + I18n.t('errors.messages.max_words')
      }
    }
  })

# GET /company/:id/edit
ga.company.hooks.editCompany = ()->
  # cover image upload
  $('#company_cover_image').live 'change', ()->
    $('#cover_image_form .alert.alert-error').hide()
    $('#cover_image_form').ajaxSubmit({
      success: (data)->
        if (data['success'])
          $('#cover_image_display').html(JST['images/_image']({image: data['image']}))
        else
          $('#cover_image_form .alert.alert-error').html(data['message'])
          $('#cover_image_form .alert.alert-error').show()
    })

  $('#company_edit_form').validate({
    onkeyup: false,
    highlight: (el)-> $(el).closest('.control-group').addClass('error')
    unhighlight: (el)-> $(el).closest('.control-group').removeClass('error')
    rules: {
      "company[name]": {
        required: true,
        unique: ()->
          company_name_array = []
          $.ajax '/company/company_names',
            type: 'get'
            async: false
            dataType: 'json'
            success: (response) ->
              company_name_array = $.map(response, (el, indx) -> el.toLowerCase())
          if $('#company_name').attr('original-name')
            _.without company_name_array, $('#company_name').attr('original-name').toLowerCase()
          else
            company_name_array
      },
      "company[region_id]": {
        non_zero: true
      }
      "company[contact_person]": {required: true}
      "company[address]": {required: true}
      "company[postal_code]": {required: true, digits: true, rangelength: [4, 4]}
      "company[city]": {required: true}
      "company[phone_numbers][]": {required: true, phoneSwiss: true}
      "company[email]": {email: true}
      "company[websites][]": {urlLoose: true}
      "company[description]": {required: true, maxWords: 100}
    }
    messages: {
      'company[name]': {
        required: I18n.t('fields.company_name') + ' ' + I18n.t('errors.messages.blank'),
        unique: I18n.t('errors.messages.company.company_name_must_be_unique')
      }
      'company[region_id]': I18n.t('errors.messages.company.company_location_must_not_be_default')
      "company[contact_person]": {
        required: I18n.t('fields.contact_person') + ' ' + I18n.t('errors.messages.blank')
      }
      "company[address]": {
        required: I18n.t('fields.address') + ' ' + I18n.t('errors.messages.blank')
      }
      "company[postal_code]": {
        required: I18n.t('fields.postal_code') + ' ' + I18n.t('errors.messages.blank')
        digits: I18n.t('errors.messages.4_digit_postal_code')
        rangelength: I18n.t('errors.messages.4_digit_postal_code')
      }
      "company[city]": {
        required: I18n.t('fields.city') + ' ' + I18n.t('errors.messages.blank')
      }
      "company[phone_numbers][]": {
        required: I18n.t('fields.phone_number') + ' ' + I18n.t('errors.messages.blank')
        phoneSwiss: I18n.t('errors.messages.phone_swiss')
      }
      "company[email]": {
        email: I18n.t('errors.messages.email')
      }
      "company[websites][]": {
        urlLoose: I18n.t('errors.messages.url')
      }
      "company[description]": {
        required: I18n.t('fields.description') + ' ' + I18n.t('errors.messages.blank')
        maxWords: I18n.t('fields.description') + ' ' + I18n.t('errors.messages.max_words')
      }
    }
  })

$(document).ready ()->
  ga.company.hooks.newCompany()
  ga.company.hooks.editCompany()

  $("#company_subcategories").tagsInput()
  $('#company_subcategories_addTag').hide()

  $("#category").change ->
    current = $(this)
    url = current.attr("data-url")
    $.get url, 
      category: current.val()

  $("#subcategory-section").delegate "input[type=checkbox]", "change", ->
    current = $(this)
    if current.is(':checked')
      $('#company_subcategories').addTag(current.val())
    else
      $('#company_subcategories').removeTag(current.val())