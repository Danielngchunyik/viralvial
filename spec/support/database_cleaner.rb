RSpec.configure do |config|

  # Before the entire suite runs, clear out test database completely
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # Set default cleaning strategy to transactions
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
end
