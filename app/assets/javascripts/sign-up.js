function onReady() {
  if ($('#profile_type_technical_recruiter_profile').is(':checked')) {
    $('#referral_code').show();
  } else {
    $('#referral_code').hide();
  }

  $('input[name=profile_type]:radio').change(function () {
    $('#referral_code').toggle(200);
    $('#referral_code').val('');
  });
};

$(function() {
	onReady() 
});