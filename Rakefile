require "rubygems"
require "rake"

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs = ["lib", "test"]
  t.pattern = 'test/**/*_test.rb'
end

desc "Run acceptance tests"
task :acceptance do
  sh %Q{ ruby test/acceptance_tests.rb }
end

task :default => [:test, :acceptance]
