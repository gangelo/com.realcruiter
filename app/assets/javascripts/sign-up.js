function onReady() {
  if ($('#profile_technical_recruiter_profile').is(':checked')) {
    $('#referral_code').show();
  } else {
    $('#referral_code').hide();
  }

  $('input[name=profile]:radio').change(function () {
    $('#referral_code').toggle(200);
    $('#referral_code').val('');
  });
};

$(document).ready(onReady);
$(document).on('page:load', onReady);