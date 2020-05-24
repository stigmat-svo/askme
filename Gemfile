source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails'
gem 'sass-rails'
gem 'webpacker'
gem 'jquery-rails'
gem 'optimist'
gem 'uglifier'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4.2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console'
  gem 'listen'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
