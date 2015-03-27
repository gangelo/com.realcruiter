Realcruiter = (typeof Realcruiter === 'undefined') ? {} : Realcruiter;
Realcruiter.Helpers = (typeof Realcruiter.Helpers === 'undefined') ? {} : Realcruiter.Helpers;

Realcruiter.Helpers = {

  CloseButton : {
    _buttonSelector : null,
    _onCloseButtonCallback : null,

    init : function(buttonSelector, onCloseButtonCallback) {
      Realcruiter.Helpers.CloseButton._buttonSelector = buttonSelector;
      Realcruiter.Helpers.CloseButton._onCloseButtonCallback = onCloseButtonCallback;

      Realcruiter.Helpers.CloseButton._attachHandlers();
    }, 

    _attachHandlers : function() {
      $(function() {
        $(document).on('click', Realcruiter.Helpers.CloseButton._buttonSelector, function(e) {
          e.preventDefault();
          if (Realcruiter.Helpers.CloseButton._onCloseButtonCallback) {
            Realcruiter.Helpers.CloseButton._onCloseButtonCallback(this);
          } else {
            $(this).remove();
          }
        });
      });
    }
  }
};