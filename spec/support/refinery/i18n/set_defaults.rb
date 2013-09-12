# encoding: utf-8

RSpec.configure do |config|
  config.before(:all) do
    Refinery::I18n.configure do |config|
      config.default_locale = :en

      config.default_frontend_locale = :en

      config.frontend_locales = [:en]

      config.locales = Refinery::I18n.built_in_locales
    end
  end
end
