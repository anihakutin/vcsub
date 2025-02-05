namespace :deploy do
  namespace :assets do
    desc 'Create asset directories'
    task :create_dirs do
      on roles(:web) do
        execute "mkdir -p #{shared_path}/app/assets/builds"
        execute "ln -s #{shared_path}/app/assets/builds #{release_path}/app/assets/builds"
        execute "mkdir -p #{release_path}/app/assets/images"
      end
    end
  end
end

# Ensure the builds directory exists and is shared between deployments
append :linked_dirs, 'app/assets/builds'

before 'deploy:assets:precompile', 'deploy:assets:create_dirs' 