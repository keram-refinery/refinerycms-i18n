# Encoding: UTF-8

require 'refinerycms-core'
require 'routing-filter'
require 'rails-i18n'
require 'i18n-iso639matrix'

module Refinery
  autoload :I18nGenerator, 'generators/refinery/i18n_generator'

  module I18n
    class << self
      attr_accessor :built_in_locales

      def built_in_locales
        @built_in_locales ||= %i(en fr nl pt pt-BR da nb sl es it de lv ru sv pl zh-CN zh-TW el rs cs sk ja bg hu uk)
      end

      def url_filter_enabled?
        config.url_filter_enabled
      end

    end

    require 'refinery/i18n/engine'
    require 'refinery/i18n/configuration'
  end
end
