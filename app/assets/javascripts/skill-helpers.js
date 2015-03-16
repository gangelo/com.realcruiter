Realcruiter = (typeof Realcruiter === 'undefined') ? {} : Realcruiter;

Realcruiter.SkillHelpers = { 
  SkillsWidget : {
    _onAddAkillCallback : null,
    _onRemoveSkillCallback : null,

    init : function(onAddSkillCallback, onRemoveSkillCallback) {
      this._onAddSkillCallback = onAddSkillCallback;
      this._onRemoveSkillCallback = onRemoveSkillCallback;

      $(function() {
        $('.skill-button').attr('disabled', true);
      });
    },

    addSkill : function(skill) {
      Realcruiter.SkillHelpers.SkillsWidget._addSkill(skill)
    },

    removeSkill : function(skill_button) {
      $(skill_button).parent().remove();
      // Give some time for jQuery to clean up, otherwise
      // out resyncing faulters.
      // setTimeout(Realcruiter.SkillHelpers.SkillsWidget._resyncSkills(), 100);
      Realcruiter.SkillHelpers.SkillsWidget._resyncSkills();
    },

    _attachHandlers : function() {
      $(function() {
        $(document).on('click','.skill-button', function() { 
          var skill = $.trim($('.skill-search').val());
          Realcruiter.SkillHelpers.SkillsWidget._onAddSkillCallback(skill); 
          $('.skill-search').val('');
          $('.skill-search').keyup();
        });

        $(document).on('keyup', '.skill-search', function() {
          var value = $(this).val();
          $(this).val(value.replace(/\s{2,}/g, ' '));
          $('.skill-button').attr('disabled', $('.skill-search').val().length === 0);
        });

        $(document).on('click', '.btn-skill', function() {
          if (Realcruiter.SkillHelpers.SkillsWidget._onRemoveSkillCallback(this)) {
            Realcruiter.SkillHelpers.SkillsWidget.removeSkill(this);
          }
        });
      });
    },

    _addSkill : function(skill) {
      var index = $('.btn-skill-name').length;

      var button = $("<button type='button' class='btn btn-lg btn-skill'/>").append("<i class='fa fa-times fa-lg'></i>&nbsp;").last().append($('<span />').text(skill));
      var input1 = $("<input type='hidden' name='" + Realcruiter.SkillHelpers.SkillsWidget._buildElementName(index, 'id') + "' id='" + Realcruiter.SkillHelpers.SkillsWidget._buildElementId(index, 'id') + "' class='btn-skill-id' value='' />");
      var input2 = $("<input type='hidden' name='" + Realcruiter.SkillHelpers.SkillsWidget._buildElementName(index, 'name') + "' id='" + Realcruiter.SkillHelpers.SkillsWidget._buildElementId(index, 'name') + "' class='btn-skill-name' value='" + skill + "' />");

      $('<span />').append(button).append(input1).append(input2).appendTo('.skills-container')
    },

    _buildElementId : function(index, skill_property) {
      return "user_profile_skills_attributes_" + index + "_" + skill_property;
    },

    _buildElementName : function(index, skill_property) {
      return "user_profile[skills_attributes][" + index + "][" + skill_property + "]";
    },

    _resyncSkills : function() {
      $('.btn-skill-id').each(function(index) {
        $(this).attr('id', Realcruiter.SkillHelpers.SkillsWidget._buildElementId(index, 'id'));
        $(this).attr('name', Realcruiter.SkillHelpers.SkillsWidget._buildElementName(index, 'id'));
      });

      $('.btn-skill-name').each(function(index) {
        $(this).attr('id', Realcruiter.SkillHelpers.SkillsWidget._buildElementId(index, 'name'));
        $(this).attr('name', Realcruiter.SkillHelpers.SkillsWidget._buildElementName(index, 'name'));
      });
    }
  }
};

Realcruiter.SkillHelpers.SkillsWidget._attachHandlers();