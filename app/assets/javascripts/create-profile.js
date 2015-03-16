// For use with user_profiles/new.html.erb
// Expects skill-helpers.js
$(function() {
  $(':submit').click(function(event) {
    if (Realcruiter.SkillHelpers.SkillsWidget.skillCount() == 0) {
      event.preventDefault();
      $('.modal').modal().show();
    }
  });

  $('.modal').on('show.bs.modal', function (event) {
    var modal = $(this);
    modal.find('.modal-title').html('<i class="fa fa-exclamation-circle fa-2x modal-title">&nbsp;Whoa, Nelly!</i>');
    modal.find('.modal-header').addClass('orange');
    modal.find('.modal-body').html("Your profile has no skills! Users can't find/connect with you if your profile has no skills!<br/><br/>If you're planning on adding skills later, click the <kbd>Thanks for the warning...</kbd> button. If you want to add skills to this profile before saving, click the <kbd>Cancel</kbd> button.");
    modal.find('.btn-ok').addClass('btn-special dark').text('Thanks for the warning, do it anyway!').click(function() { $(':submit').off('click'); $(':submit').click(); });
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