source 'https://rubygems.org'
ruby '2.5.7'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.5'
gem 'pg', '1.1.3'

gem 'puma', '~> 3.7'
gem 'redis', '~> 4.0.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Scrapin'
gem 'geocoder', '~> 1.6.1'
gem 'mechanize', '~> 2.7.5', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0' # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
