require "./blockchain_proxy"
#require 'resque/tasks'
#require 'bootstrap_chef_client'
#require 'bootstrap_chef_server'
#require 'bootstrap_chef_workstation'

# require 'rake/testtask'
Dir.glob('lib/tasks/*.rake').each { |r| load r}
# Rake::TestTask.new do |t|
#   t.libs << "test"
#   t.test_files = FileList['test/test*.rb']
#   t.verbose = true
# end

task default: ["blockchain:show_version"]
