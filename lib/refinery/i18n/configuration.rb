module Refinery
  module I18n
    include ActiveSupport::Configurable

    config_accessor :default_locale, :locales,
                    :default_frontend_locale, :frontend_locales,
                    :fallbacks_enabled, :url_filter_enabled

    self.default_locale = :en
    self.locales = self.built_in_locales
    self.default_frontend_locale = self.default_locale
    self.frontend_locales = [self.default_frontend_locale]
    self.fallbacks_enabled = true
    self.url_filter_enabled = true
  end
end
