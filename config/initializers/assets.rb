require 'will_paginate/array'

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

#
# Controller assets
Rails.application.config.assets.precompile += %w( 
  dashboards.js
  dashboards.css
  home.css
  home.js
  search.js
  search.css 
  user_profiles.js
  user_profiles.css

  user_profiles_show.js
)

#
# Miscellaneous assrts
Rails.application.config.assets.precompile += %w( 
  close-button.js
  create-profile.js 
  delete-profile.js 
  modal-dialog-center.js
  sign-up.js 
  skill-helpers.js 
  skill-search.js 
  skills-search.js 
)

#
# 3rd-Party assets
Rails.application.config.assets.precompile += %w( 
  jquery-ui/autocomplete.js 
  jquery-ui/autocomplete.css 
)