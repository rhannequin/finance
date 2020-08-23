# frozen_string_literal: true

RSpec.configure do |config|
    config.use_transactional_fixtures = true
  
    config.before(:suite) do
      DatabaseCleaner.clean_with(:deletion)
    end
  
    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end
  
    config.before(:each, non_transactional: true) do
      DatabaseCleaner.strategy = :deletion
    end
  
    config.before(:each, js: true) do
      DatabaseCleaner.strategy = :truncation
    end
  
    config.before(:each) do
      DatabaseCleaner.start
    end
  
    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
  