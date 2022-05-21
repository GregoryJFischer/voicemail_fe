JS_DRIVER = :selenium_chrome_headless

Capybara.default_driver = :rack_test
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 2

Capybara.register_driver :selenium do |app|

  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 120

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome( :elementScrollBehavior => 1 )

  Capybara::Selenium::Driver.new(
    app,
    :browser => :firefox,
    :desired_capabilities  => capabilities,
    :http_client => http_client
  )
end

RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_driver = JS_DRIVER if example.metadata[:js]
    Capybara.current_driver = :selenium if example.metadata[:selenium]
    Capybara.current_driver = :selenium_chrome if example.metadata[:selenium_chrome]
  end

  config.after(:each) do
    Capybara.use_default_driver
  end
end