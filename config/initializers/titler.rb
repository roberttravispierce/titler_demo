Titler.configure do |config|
  config.use_env_prefix = false
  config.delimiter = ' / '
  config.app_name_position = 'append' # append, prepend, none
  config.use_app_tagline = false
  config.admin_name = 'Admin'
  config.admin_controller = AdminController
end
