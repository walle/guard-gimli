source "http://rubygems.org"

gemspec

group :test do
  gem 'guard'
  gem 'guard-rspec'
  if RUBY_PLATFORM =~ /linux/i
    gem 'rb-inotify'
    gem 'libnotify'
  end
end

