# create namespace
ga = window.ga || {}
ga.base = ga.base || {}
ga.base.hooks = ga.base.hooks || {}
window.ga = ga

ga.base.hooks.formCookie = ()->
  $('form.remember-cookie').find('input, textarea, select').each ()->
    # ignore hidden or submit element
    if $(this).attr('type') and $(this).attr('type').toLowerCase() in ['submit', 'hidden', 'password']
      return

    # set values from cookie if we have them
    name = $(this).attr('name')
    if ($.cookie(name))
      $(this).val($.cookie(name))

    # set cookie onblur
    $(this).blur ()->
      $.cookie(name, $(this).val())

ga.base.hooks.raty = ()->
  # display editable rating
  $('.star').raty({
    path: '/assets'
    score: ()->
      $(this).attr('score')
    scoreName: ()->
      $(this).attr('score-name')
    readOnly: ()->
      $(this).hasClass('readonly')
  })

ga.base.hooks.qtip = ()->
  $('.tooltippable').qtip({
    position: {
      my: 'left center'
      at: 'right center'
    }
    show: 'focus'
    hide: 'unfocus'
    style: {
      classes: 'ui-tooltip-green'
    }
  })

ga.base.hooks.tooltip = ()->
  $('.add_tooltip').tooltip()

ga.base.hooks.clearme = ()-> 
  value = ''
  $('.clearme').focus ()->
    value = $(this).val()
    $(this).val('')
	
  $('.clearme').blur ()->
    x = $(this).val()
    if (x=='') then $(this).val(value)

ga.base.hooks.tagsInput = ()->
  $('#company_specialties').tagsInput autocomplete_url: $('#company_specialties').attr("data-autocomplete-source")

ga.base.hooks.placeholder = ()->
  $('input, textarea').placeholder()

ga.base.hooks.fileupload = ()->
  $('#fileupload').fileupload({
    uploadTemplateId: null,
    downloadTemplateId: null,
    uploadTemplate: (o)->
      tmpl = JST['images/_uploads']({o: o})
      return $(tmpl)
    downloadTemplate: (o)->
      tmpl = JST['images/_downloads']({o: o})
      return $(tmpl)
    acceptFileTypes: /(png)|(jpe?g)|(gif)$/i
  })

  # Enable iframe cross-domain access via redirect option:
  $('#fileupload').fileupload(
    'option',
    'redirect',
    window.location.href.replace(
      /\/[^\/]*$/,
      '/cors/result.html?%s'
    )
  )

  # Load existing files
  $('#fileupload').each ()->
    that = this;
    $.getJSON this.action, (files)->
      if (files && files.length)
        $(that).fileupload('option', 'done')
          .call(that, null, {result: files})

ga.base.hooks.i18n = ()->
  I18n.defaultLocale = "de"

ga.base.hooks.autocomplete = ()->
  $('.autocomplete').autocomplete({
    source: (data, callback)->
      url = $(this.element).attr('source-url')
      if url
        $.ajax({
          url: url,
          data: data,
          dataType: "json",
          success: ( data, status )->
            callback( data )
          , error: ()->
            callback( [] )
        })
  })

$(document).ready ()->
  ga.base.hooks.i18n()
  ga.base.hooks.tooltip()
  ga.base.hooks.tagsInput()
  ga.base.hooks.raty()
  ga.base.hooks.formCookie()
  ga.base.hooks.placeholder()
  ga.base.hooks.clearme()
  ga.base.hooks.fileupload()
  ga.base.hooks.autocomplete()
  $(".calendar").datepicker({
    dateFormat: "yy-mm-dd"
  })