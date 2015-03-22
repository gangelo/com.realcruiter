// For use with user_profiles/new.html.erb
// Expects skill-helpers.js
$(function() {
  var submitButtonSelector = ':submit[id=btn-create-profile]';
  var cancelButtonSelector = '.btn-cancel';

  $(submitButtonSelector).click(function(event) {
    if (Realcruiter.SkillHelpers.SkillsWidget.skillCount() == 0) {
      event.preventDefault();
      showSubmitModal();
    }
  });

  $(cancelButtonSelector).click(function(event) {
    event.preventDefault();
    showCancelModal();
  });

  function showSubmitModal() {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">Whoa, Nelly!</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("Your profile has no skills; other users will not be able to find/connect with you until it does! Click the <i>Thanks for the warning...</i> button if you plan on adding skills later. Click the <i>Cancel</i> button if you'd like to add them now.");
      modal.find('.btn-ok').addClass('btn-special dark')
        .text("Thanks for the warning, create my profile!")
        .click(function() { $(submitButtonSelector).off('click'); $(submitButtonSelector).click(); });
      modal.find('.btn-cancel').addClass('btn-default').text('Cancel');
    });
    showModal();
  };

  function showCancelModal() {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">O Rly?</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("Any changes you've' made will be lost. Are you sure you want to cancel?");
      modal.find('.btn-ok')
        .addClass('btn-special dark')
        .text("Yep, I'm sure!")
        .click(function() { $(cancelButtonSelector).off('click'); $(cancelButtonSelector)[0].click(); });
      modal.find('.btn-cancel').addClass('btn-default').text('No');
    });
    showModal();
  };

  function showModal() {
    $('.modal').modal().show();
  };
});

function onAddSkill(skill) {
  Realcruiter.SkillHelpers.SkillsWidget.addSkill(skill);
};

function onRemoveSkill(skill_button) {
  return true;
};

Realcruiter.SkillHelpers.SkillsWidget.init('.user-profile-type', onAddSkill, onRemoveSkill);  

