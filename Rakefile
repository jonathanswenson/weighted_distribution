require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new(:spec) do |t|
  t.fail_on_error = false
  t.rspec_opts = '--format documentation'
end

task :default => :spec
