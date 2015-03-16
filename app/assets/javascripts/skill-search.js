$(function() {
  var cache = {};
  $(".skill-search").autocomplete({
    minLength: 1,
    source: function(request, response) {
      var term = request.term;
      if (term in cache) {
        response(cache[term]);
        return;
      }

      $.getJSON("/profiles/skills.json", request, function(data, status, xhr) {
        cache[term] = data;
        response(data);
      });
    }
  });
});