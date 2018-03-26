require 'active_support/inflector'

module Rurl
  class Curl
    class << self
      METHODS = {
        GET: 'Rurl::Method::Get'
      }

      def execute(config)
        validate(config)
        m = METHODS[config.method.to_sym].constantize.new(config)

        cmds = [
          'curl -sS',
          m.args,
          m.method,
          m.headers,
          m.params,
          m.url,
        ]
        puts `#{cmds.compact.join(' ')}`
      end

      def validate(config)
        unless METHODS.include?(config.method.to_sym)
          raise NotSupportedMethod, "not supported method: #{config.method}"
        end

        unless config.url
          raise NotGivenUrl, "please input url"
        end
      end
    end
  end
end
