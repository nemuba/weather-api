namespace :fly do
  desc "server: run rails server"

  task :server do
    sh 'bin/rails server'
  end
end
