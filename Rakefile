require 'rake/testtask'
require 'bundler'

task :build do
  begin
    puts 'building gem...'
    `gem build coinbase_exchange.gemspec`
  rescue
    puts 'build failed.'
  end
end

task :install do
  begin
    puts 'installing gem...'
    `gem install coinbase_exchange-0.0.3.gem`
  rescue
    puts 'install failed.'
  end
end

task :console do
  require 'rubygems'
  require 'pry'
  ARGV.clear
  PRY.start
end

task :default => ['build', 'install']

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/tc*.rb']
  t.verbose = true
end
