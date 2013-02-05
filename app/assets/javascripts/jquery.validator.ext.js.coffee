#
# jQuery Validator plugin rules extensions
#

# Validate value has non-zero value
$.validator.addMethod 'non_zero', (value, element, param)->
  return (parseInt(value, 10) != 0)
, 'Value must be non-zero'

# Validate value on uniqueness
$.validator.addMethod 'unique', (value, element, param)->
  return ($.inArray(value.toLowerCase(), param) == -1)
, 'Value should be unique'

$.validator.addMethod 'urlLoose', (value, element)->
  return this.optional(element) || ga.validation.isValidUrl(value)
, 'Please enter a valid url'

$.validator.addMethod 'phoneSwiss', (value, element)->
  return this.optional(element) || ga.validation.isValidSwissPhoneNumber(value)
, 'Please enter a valid Swiss phone number'

$.validator.addMethod 'maxWords', (value, element, max_word)->
  return true if this.optional(element)

  value = value.trim()
  words = value.split(/[\s\.,\?\!]+/)
  return words.length < max_word
, jQuery.format('Please enter description in less than {0} words')
