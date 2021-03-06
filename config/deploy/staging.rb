set :stage, :staging
set :branch, "staging"

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :server_name, "hpi-career-dev"

server '172.16.65.86', user: "#{fetch(:deploy_user)}", roles: %w{web app db}, primary: true

set :deploy_to, "/var/www/#{fetch(:application)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :staging

set :whenever_environment, "#{fetch(:stage)}"

set :assets_prefix, '/assets'

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_worker_count, 5

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false

# files that need to be symlinked by deploy:setup_config
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:full_app_name)}"
  }
])
