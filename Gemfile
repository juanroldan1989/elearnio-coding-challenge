source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.7"

gem "faker", "~> 2.22.0"
gem "pg", "~> 1.4.6"
gem "puma", "~> 3.11"
gem "rails", "~> 6.0.0"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
end

group :test do
  gem "factory_bot_rails", "~> 6.2.0"
  gem "rspec-rails", "~> 5.1.2"
  gem "shoulda-matchers", "~> 4.5.1"
end
