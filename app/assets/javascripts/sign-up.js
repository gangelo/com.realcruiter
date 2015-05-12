$(function() {
	if ($('#profile_type_TechnicalRecruiterProfile').is(':checked')) {
    $('#referral_code').show();
  } else {
    $('#referral_code').hide();
  }

  $('input[name=profile_type]:radio').change(function () {
    $('#referral_code').toggle(200);
    $('#referral_code').val('');
  });
});