require 'bundler/setup'

desc 'Run specs in correct order'
task :spec do
  folders = %w[units integrations]
  folders.each do |folder|
    pattern = "./spec/#{folder}/*_spec.rb"
    next if Dir[pattern].empty?

    puts '-' * 100
    puts "Specs for #{folder} folder"
    puts '-' * 100

    sh "bundle exec rspec #{pattern}" 
  end
end