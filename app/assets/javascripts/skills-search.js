$(function() {
    function split(val) {
      return val.split(/,\s*/);
    };

    function extractLast(term) {
      return split(term).pop();
    };
 
    $('.search-textbox')
      // Don't navigate away from the field on tab when selecting an item
      .bind('keydown', function(event) {
        if (event.keyCode === $.ui.keyCode.TAB && $(this).autocomplete('instance').menu.active) {
          event.preventDefault();
        }
      })
      .autocomplete({
        source: function(request, response) {
          $.getJSON('/search/skills.json', {
            term: extractLast(request.term)
          }, response);
        },
        search: function() {
          // Custom minLength
          var term = extractLast(this.value);
          if (term.length == 0) {
            return false;
          }
        },
        focus: function() {
          // Prevent value inserted on focus
          return false;
        },
        select: function(event, ui) {
          var terms = split(this.value);
          // Remove the current input
          terms.pop();
          // Add the selected item
          terms.push(ui.item.value);
          // Add placeholder to get the comma-and-space at the end
          terms.push('');
          this.value = terms.join(', ');
          return false;
        }
      });
  });