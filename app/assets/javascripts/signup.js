$(function () {
  if ($('#user_user_type_technical_rectuiter').is(':checked')) {
    $('#referral_code').show();
  } else {
    $('#referral_code').hide();
  }

  $('input[name=user\\[user_type\\]]:radio').change(function () {
    $('#referral_code').toggle(250);
    $('#referral_code').val('');
  });
});