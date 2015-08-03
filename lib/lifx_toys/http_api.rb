require 'json'
require 'httparty'

module LifxToys
  module HttpApi
    class << self

      def set_color(selector, color, options = { duration: 2.0,
                                                 power_on: true})
        HTTParty.put(color_url(selector),
                     headers: authorization_headers,
                     query: options.merge({
                       color: color
                     }))
      end

      def get_light_info(selector)
        HTTParty.get(info_url(selector),
                     headers: authorization_headers)
      end

      def set_power_state (selector, state, options = {duration: 2})
        HTTParty.put(power_url(selector),
                     headers: authorization_headers,
                     query: options.merge({
                       state: state
                     }))
      end

      def toggle_power_state (selector)
        HTTParty.post(toggle_power_url(selector),
                     headers: authorization_headers)
      end

      private

      def info_url(selector)
        "https://api.lifx.com/v1beta1/lights/#{selector}"
      end

      def toggle_power_url(selector)
        "#{info_url(selector)}/toggle"
      end

      def power_url(selector)
        "#{info_url(selector)}/power"
      end

      def color_url(selector)
        "#{info_url(selector)}/color"
      end

      def authorization_headers
        {"Authorization" => "Bearer #{ENV["LIFX_TOKEN"]}"}
      end
    end
  end
end
