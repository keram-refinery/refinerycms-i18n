source 'https://rubygems.org'

gemspec

gem 'refinerycms', '~> 3.0.0.dev', github: 'keram-refinery/refinerycms', branch: 'refinery_light', group: :test
gem 'refinerycms-testing', '~> 3.0.0.dev', group: :test

# Database Configuration
unless ENV['TRAVIS']
  gem 'activerecord-jdbcsqlite3-adapter', platform: :jruby
  gem 'sqlite3', platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
  gem 'activerecord-jdbcmysql-adapter', platform: :jruby
  gem 'jdbc-mysql', '= 5.1.13', platform: :jruby
  gem 'mysql2', platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'pg', platform: :ruby
end

gem 'jruby-openssl', platform: :jruby

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

# Load local gems according to Refinery developer preference.
if File.exist? local_gemfile = File.expand_path('../.gemfile', __FILE__)
  eval File.read(local_gemfile)
end
