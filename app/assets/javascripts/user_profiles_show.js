// For use with user_profiles/show.html.erb
$(function() {
  var submitButtonSelector = ':submit[id=btn-request-connect]';
  var cancelButtonSelector = '.btn-cancel';

  $(submitButtonSelector).click(function(event) {
    event.preventDefault();
    showSubmitModal();
  });

  $(cancelButtonSelector).click(function(event) {
    event.preventDefault();
    showCancelModal();
  });

  function showSubmitModal() {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">Bang Zooooooom!</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("It looks like you want to send a <i>request-to-connect</i> to this user! Are you sure want me to send it?");
      modal.find('.btn-ok').addClass('btn-special dark')
        .text("Yep, send it!")
        .click(function() { $(submitButtonSelector).off('click'); $(submitButtonSelector).click(); });
      modal.find('.btn-cancel').addClass('btn-default').text('Cancel');
    });
    showModal();
  };

  function showCancelModal() {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">Leaving so soon?</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("You've neglected to send a <i>request-to-connect</i> to this user. Are you sure you want to cancel?");
      modal.find('.btn-ok')
        .addClass('btn-special dark')
        .text("Yes, cancel.")
        .click(function() { $(cancelButtonSelector).off('click'); $(cancelButtonSelector)[0].click(); });
      modal.find('.btn-cancel').addClass('btn-default').text('No');
    });
    showModal();
  };

  function showModal() {
    $('.modal').modal().show();
  };
});