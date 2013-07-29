module Refinery
  module I18n
    class Engine < Rails::Engine
      config.before_initialize do
        require File.expand_path('../../i18n-filter', __FILE__)
        require File.expand_path('../../translate', __FILE__)
      end

      initializer 'configure fallbacks' do
        if I18n.fallbacks_enabled
          require 'i18n/backend/fallbacks'
          if defined?(::I18n::Backend::Simple) && defined?(::I18n::Backend::Fallbacks)
            ::I18n::Backend::Simple.send(:include, ::I18n::Backend::Fallbacks)
          end
        end
      end

      initializer 'register refinery_i18n stylesheets' do
        Refinery::Core.config.register_admin_stylesheet('refinery/refinery-i18n')
      end

      config.to_prepare do
        ::ApplicationController.module_eval do

          def default_url_options_with_locale options={}
            options.merge(locale: ::I18n.locale) if ::I18n.locale != I18n.default_frontend_locale
            options.merge(default_url_options_without_locale)
          end

          alias_method_chain :default_url_options, :locale

          def find_or_set_locale
            ::I18n.locale = if current_refinery_user
              current_refinery_user.locale
            elsif I18n.locales.keys.include?(params[:locale])
              params[:locale]
            else
              I18n.default_locale
            end

            Globalize.locale = params[:locale]
          end

          prepend_before_action :find_or_set_locale
          protected :default_url_options, :find_or_set_locale
        end

        ::Refinery::AdminController.class_eval do
          def find_or_set_locale
            ::I18n.locale = current_refinery_user ? current_refinery_user.locale : I18n.default_locale
            Globalize.locale = if params[:frontend_locale] =~ frontend_locales_rgxp
              params.delete(:frontend_locale)
            elsif ::I18n.locale =~ frontend_locales_rgxp
              ::I18n.locale
            else
              I18n.default_frontend_locale
           end
          end

          def frontend_locales_rgxp
            @@frontend_locales_rgxp ||= %r{\A(#{I18n.frontend_locales.join('|')})\z}
          end

          prepend_before_action :find_or_set_locale
          protected :find_or_set_locale
          private :frontend_locales_rgxp

        end
      end

      initializer 'register refinery_i18n plugin' do
        ::Refinery::Plugin.register do |plugin|
          plugin.name = 'refinery_i18n'
          plugin.hide_from_menu = true
          plugin.always_allow_access = true
          plugin.pathname = root
        end
      end

    end
  end
end
