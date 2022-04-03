# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include FactoryBot::Syntax::Methods
  config.before(:each, type: :system) do
      driven_by(:selenium_chrome_headless)
    end

    config.before(:each, type: :system, js: true) do
      driven_by(:selenium_chrome_headless)
    end
    
    config.after(:each, type: :system) do
      FileUtils.rm Dir.glob(Rails.root.join('*.pdf'))
    end
    config.after(:each, type: :system, js: true) do
      FileUtils.rm Dir.glob(Rails.root.join('*.pdf'))
    end
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end

  VCR.configure do |c|
    c.ignore_localhost = false
    c.cassette_library_dir = 'spec/vcr'
    c.hook_into :webmock
    c.configure_rspec_metadata!
    c.default_cassette_options = {
      match_requests_on: %i[method]
    }
    c.allow_http_connections_when_no_cassette = true
    c.default_cassette_options = { re_record_interval: 12.hours }
  end
end
OmniAuth.config.silence_get_warning = true
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                     provider: 'google_oauth2',
                                                                     uid: '123456789',
                                                                     info: {
                                                                       name: 'John Doe',
                                                                       email: 'john.doe@example.com',
                                                                       first_name: 'John',
                                                                       last_name: 'Doe',
                                                                       image: 'https://lh3.googleusercontent.com/url/photo.jpg'
                                                                     },
                                                                     credentials: {
                                                                       token: 'token',
                                                                       refresh_token: 'another_token',
                                                                       expires_at: 1_354_920_555,
                                                                       expires: true
                                                                     }
                                                                   })
  def wait_for_stripe_pageload(limit = 50)
    time_counter = 0

    until (time_counter == limit || page.has_css?('.ProductSummary'))
      sleep 0.1
      time_counter += 1
    end
  end