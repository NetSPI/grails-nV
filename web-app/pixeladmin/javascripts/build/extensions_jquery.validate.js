(function() {
  if (!$.validator) {
    throw new Error('jquery.validate.js required');
  }

  $.validator.setDefaults({
    highlight: function(element) {
      return $(element).closest('.form-group').addClass('has-error');
    },
    unhighlight: function(element) {
      return $(element).closest('.form-group').removeClass('has-error').find('help-block-hidden').removeClass('help-block-hidden').addClass('help-block').show();
    },
    errorElement: 'div',
    errorClass: 'jquery-validate-error',
    errorPlacement: function(error, element) {
      var $p, has_e, is_c;
      is_c = element.is('input[type="checkbox"]') || element.is('input[type="radio"]');
      has_e = element.closest('.form-group').find('.jquery-validate-error').length;
      if (!is_c || !has_e) {
        if (!has_e) {
          element.closest('.form-group').find('.help-block').removeClass('help-block').addClass('help-block-hidden').hide();
        }
        error.addClass('help-block');
        if (is_c) {
          return element.closest('[class*="col-"]').append(error);
        } else {
          $p = element.parent();
          if ($p.is('.input-group')) {
            return $p.parent().append(error);
          } else {
            return $p.append(error);
          }
        }
      }
    }
  });

}).call(this);
