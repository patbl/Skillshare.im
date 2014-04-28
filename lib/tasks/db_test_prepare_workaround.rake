desc "Dummy task to maybe prevent build from failing"
namespace :db do
  task 'test:prepare' => :environment
end
