require "rubygems"
require "rake"

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs = ["lib", "test"]
end

desc "Run acceptance tests"
task :acceptance do
  sh %Q{ ruby tests/acceptance_tests.rb }
end

task :default => [:test, :acceptance]
