// For use with user_profiles/new.html.erb
// Expects skill-helpers.js
$(function() {
  var deleteButtonSelector = '.btn-delete';

  $(deleteButtonSelector).each(function() {
    $(this).click(function(event) {
      event.preventDefault();
      showDeleteModal(this);
    });
  });

  function showDeleteModal(delete_button) {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">Whoa, take it easy!</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("Are you sure you want to delete profile <i>" + $(delete_button).data('profile-name') + '</i>?');
      modal.find('.btn-ok').addClass('btn-special dark')
        .text("Thanks for the warning, delete it!")
        .click(function() { $(delete_button).off('click'); $(delete_button).click(); });
      modal.find('.btn-cancel').addClass('btn-default').text('Cancel');
    });
    showModal();
  };

  function showModal() {
    $('.modal').modal().show();
  };
});
