require 'will_paginate/array'

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

#
# Controller assets
Rails.application.config.assets.precompile += %w( 
  connections.js connections.css
  dashboards.js dashboards.css
  home.css home.js
  registrations.js registrations.css
  search.js search.css 
  sessions.js sessions.css
  user_profiles.js user_profiles.css
  user_profiles_show.js
)

#
# Miscellaneous assets
Rails.application.config.assets.precompile += %w( 
  close-button.js
  connections_accept_reject.js
  create-profile.js 
  delete-profile.js 
  modal-dialog-center.js
  popover.js
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