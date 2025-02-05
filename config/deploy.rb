namespace :deploy do
  namespace :assets do
    desc 'Create asset directories'
    task :create_dirs do
      on roles(:web) do
        execute "mkdir -p #{release_path}/app/assets/builds"
        execute "mkdir -p #{release_path}/app/assets/images"
      end
    end
  end
end

before 'deploy:assets:precompile', 'deploy:assets:create_dirs' 