require 'rubygems'
require 'simplecov'
require_relative 'mock_tire'
require 'webmock'

SimpleCov.start 'rails'
Tire.disable!

prefork = lambda do
  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
  ENV["RAILS_ENV"] = 'test'

  require File.expand_path("../../config/environment", __FILE__)

  require "rails/application"
  require 'rspec/rails'
  require 'capybara/rails'
  require 'capybara/rspec'
  require "rack_session_access/capybara"

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f }

  # Requires supporting ruby files for capybara
  Dir[Rails.root.join("spec/features/steps/**/*.rb")].each {|f| require f }

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    config.include FactoryGirl::Syntax::Methods
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    #devise test helpers
    config.include Devise::TestHelpers, :type => :controller

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, :js => true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    # disable tire and elastic search for non elastic search based tests
    config.around do |example|
      if !example.metadata[:elasticsearch]
        example.call
      else
        Tire.enable! do
          example.call
        end
      end
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # delete image uploads
    config.after(:all) do
      if Rails.env.test?
        FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
      end
    end
  end

  #use different directories for file uploads
  if defined?(CarrierWave)
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

end

each_run = lambda do
  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
  FactoryGirl.reload
end

if defined?(Zeus)
  prefork.call
  $each_run = each_run
  class << Zeus.plan
    def after_fork_with_test
      after_fork_without_test
      $each_run.call
    end
    alias_method_chain :after_fork, :test
  end
else
  prefork.call
  each_run.call
end
