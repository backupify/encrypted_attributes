#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
require 'ci/reporter/rake/test_unit'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test" << "."
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end


