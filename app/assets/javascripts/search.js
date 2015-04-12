
$(function() {
  $('ul.dropdown-menu').on('click', 'li>a.profile-search-link', function() {
    var profileId = $(this).data('profile-id');

    $.get("/search/search_profile_skills", {profile_id: profileId}, function(data, status, xhr) {
        $('.skills-container').html(data);
      }).fail(function(jqxhr, textStatus, error) {
        // TODO: Handle this error.
        // var err = textStatus + ", " + error;
    });
  });
});