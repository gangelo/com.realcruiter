// For use with user_profiles/new.html.erb
// Expects skill-helpers.js
$(function() {
  var submitButtonSelector = ':submit[id=btn-create-profile]';

  $(submitButtonSelector).click(function(event) {
    if (Realcruiter.SkillHelpers.SkillsWidget.skillCount() == 0) {
      event.preventDefault();
      $('.modal').modal().show();
    }
  });

  $('.modal').on('show.bs.modal', function (event) {
    var modal = $(this);
    modal.find('.modal-title').html('<span class="fa fa-2x">Whoa, Nelly!</i>');
    modal.find('.modal-header').addClass('orange');
    modal.find('.modal-body').html("Your profile has no skills; other users will not be able to find/connect with you until it does! Click the <kbd>Thanks for the warning...</kbd> button if you plan on adding skills later. Click the <kbd>Cancel</kbd> button if you'd like to add them now.");
    modal.find('.btn-ok').addClass('btn-special dark').text("Thanks for the warning, I'll add them later.").click(function() { $(submitButtonSelector).off('click'); $(submitButtonSelector).click(); });
    modal.find('.btn-cancel').addClass('btn-default').text('Cancel');
  });
});

function onAddSkill(skill) {
  Realcruiter.SkillHelpers.SkillsWidget.addSkill(skill);
};

function onRemoveSkill(skill_button) {
  return true;
};

Realcruiter.SkillHelpers.SkillsWidget.init(onAddSkill, onRemoveSkill);  