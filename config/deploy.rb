# set :application, "set your application name here"
# set :repository,  "set your repository location here"
# 
# set :scm, :subversion
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# 
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"
# 
# # if you're still using the script/reaper helper you will need
# # these http://github.com/rails/irs_process_scripts
# 
# # If you are using Passenger mod_rails uncomment this:
# # namespace :deploy do
# #   task :start do ; end
# #   task :stop do ; end
# #   task :restart, :roles => :app, :except => { :no_release => true } do
# #     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
# #   end
# # end

# be sure to change these
set :user, 'anand'
set :domain, 'localhost'
set :application, 'sample_app'
# file paths
set :repository,  "git@github.com:askumar/sample_app.git"
set :deploy_to, "/Users/anand/rails_projects/examples/sample_app"
role :app, domain
role :web, domain
role :db, domain, :primary => true

set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
namespace :deploy do
   desc "cause Passenger to initiate a restart"
   task :restart do
      run "touch #{current_path}/tmp/restart.txt"
   end
   desc "reload the database with seed data"
   task :seed do
     run "cd #{current_path}; rake db:seed RAILS_ENV=production"
   end 
end
  after "deploy:update_code", :bundle_install
  desc "install the necessary prerequisites"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end