RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request # sign_inヘルパーを提供してくれます
  config.include FactoryBot::Syntax::Methods # ついでにFactoryBotもincludeしておきます
end
