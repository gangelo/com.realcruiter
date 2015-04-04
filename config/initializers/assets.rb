require 'will_paginate/array'

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( sign-up.js skill-search.js skills-search.js skill-helpers.js create-profile.js modal-dialog-center.js )
Rails.application.config.assets.precompile += %w( delete-profile.js close-button.js )
Rails.application.config.assets.precompile += %w( jquery-ui/autocomplete.js jquery-ui/autocomplete.css )