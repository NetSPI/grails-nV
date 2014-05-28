# -------------------------------------------------------------------
# extensions / jquery.validate.coffee
#

throw new Error('jquery.validate.js required') if not $.validator

$.validator.setDefaults
  highlight: (element) ->
    $(element).closest('.form-group').addClass('has-error')
  
  unhighlight: (element) ->
    $(element).closest('.form-group').removeClass('has-error').find('help-block-hidden').removeClass('help-block-hidden').addClass('help-block').show()
  
  errorElement: 'div'
  errorClass: 'jquery-validate-error'
  errorPlacement: (error, element) ->
    is_c = element.is('input[type="checkbox"]') or element.is('input[type="radio"]')
    has_e = element.closest('.form-group').find('.jquery-validate-error').length
    if not is_c or not has_e
      element.closest('.form-group').find('.help-block').removeClass('help-block').addClass('help-block-hidden').hide() unless has_e
      error.addClass('help-block')
      if is_c
        element.closest('[class*="col-"]').append(error)
      else
        $p = element.parent()
        if $p.is('.input-group')
          $p.parent().append(error)
        else
          $p.append(error)
