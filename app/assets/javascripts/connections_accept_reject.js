$(function() {
  var submitButtonSelector = ':submit[id=btn-accept]';
  var rejectButtonSelector = ':submit[id=btn-reject]';

  $(submitButtonSelector).click(function(event) {
    event.preventDefault();
    showSubmitModal();
  });

  $(rejectButtonSelector).click(function(event) {
    event.preventDefault();
    showRejectModal();
  });

  function showSubmitModal() {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">Git-R-Done!</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("If you accept this connect request, your contact information will be shared with the other user. Do you still want to accept this request?");
      modal.find('.btn-ok').addClass('btn-special dark')
        .text("Yes, I accept!")
        .click(function() { 
          $(submitButtonSelector).off('click'); 
          $('#request_action').val('accept');
          $(submitButtonSelector).click(); 
        });
      modal.find('.btn-cancel').addClass('btn-default').text('Cancel');
    });
    showModal();
  };

  function showRejectModal() {
    $('.modal').on('show.bs.modal', function (event) {
      var modal = $(this);
      modal.find('.modal-title').html('<span class="fa fa-2x">Ouch!</i>');
      modal.find('.modal-header').addClass('orange');
      modal.find('.modal-body').html("You're about to reject this connect request. Are you sure you want to do this?");
      modal.find('.btn-ok')
        .addClass('btn-special dark')
        .text("Yep, I'm sure!")
        .click(function() { 
          $(rejectButtonSelector).off('click'); 
          $('#request_action').val('reject');
          $(rejectButtonSelector).click(); 
        });
      modal.find('.btn-cancel').addClass('btn-default').text('No');
    });
    showModal();
  };

  function showModal() {
    $('.modal').modal().show();
  };
});