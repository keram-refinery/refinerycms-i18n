module RoutingFilter
  class RefineryLocales < Filter

    PATH_LOCALE_REGEXP = %r(^/(([a-zA-Z\-_])*)(?=/|$))
    RESULT_SUB_REGEXP = %r(^(https?://[^/]*)?(.*))

    def around_recognize(path, env, &block)
      if path =~ locales_regexp
        path.sub! PATH_LOCALE_REGEXP do
          ::I18n.locale = $1
          ''
        end
        path.sub!(%r{^$}) { '/' }
      else
        ::I18n.locale = ::Refinery::I18n.default_frontend_locale
      end

      yield.tap do |params|
        params[:locale] = ::I18n.locale
      end
    end

    def around_generate(params, &block)
      locale = params.delete(:locale) || ::I18n.locale

      yield.tap do |result|
        result = result.is_a?(Array) ? result.first : result
        if locale != ::Refinery::I18n.default_frontend_locale &&
           result !~ refinery_backend_regexp
          result.sub!(RESULT_SUB_REGEXP) { "#{$1}/#{locale}#{$2}" }
        end
      end
    end

    private

    def locales_regexp
      @@locales_regexp ||= %r{^/(#{::Refinery::I18n.frontend_locales.join('|')})(/|$)}
    end

    def refinery_backend_regexp
      @@refinery_backend_regexp ||= %r{^/(#{Refinery::Core.backend_route})}
    end
  end
end
