source 'https://rubygems.org'

gemspec

gem 'refinerycms', '~> 3.0.0.dev', :git => 'git://github.com/keram-refinery/refinerycms.git', :branch => 'refinery_light'

gem 'rails-i18n', '~> 0.7.4', :git => 'git://github.com/svenfuchs/rails-i18n.git', :branch => 'rails-4-x'
gem 'routing-filter', '~> 0.3.1', :git => 'git://github.com/svenfuchs/routing-filter.git', :branch => 'master'

group :test do
  gem 'refinerycms-testing'
  gem 'guard-rspec', '~> 3.0.2'

  platforms :mswin, :mingw do
    gem 'win32console', '~> 1.3.0'
    gem 'rb-fchange', '~> 0.0.5'
    gem 'rb-notifu', '~> 0.0.4'
  end

  platforms :ruby do
    unless ENV['TRAVIS']
      require 'rbconfig'
      if /darwin/i === RbConfig::CONFIG['target_os']
        gem 'rb-fsevent', '~> 0.9.0'
        gem 'ruby_gntp', '~> 0.3.4'
      end
      if /linux/i === RbConfig::CONFIG['target_os']
        gem 'rb-inotify', '~> 0.9.0'
        gem 'libnotify',  '~> 0.8.1'
        gem 'therubyracer', '~> 0.11.4'
      end
    end
  end

  platforms :jruby do
    unless ENV['TRAVIS']
      require 'rbconfig'
      if /darwin/i === RbConfig::CONFIG['target_os']
        gem 'ruby_gntp', '~> 0.3.4'
      end
      if /linux/i === RbConfig::CONFIG['target_os']
        gem 'rb-inotify', '~> 0.9.0'
        gem 'libnotify',  '~> 0.8.1'
      end
    end
  end
end
