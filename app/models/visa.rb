module Visa
  module CyberSource
    module InstanceMethods
      require 'digest'

      def headers
        @headers ||= { 
                        'Content-Type' => 'application/json', 
                        'x-pay-token' =>  x_pay_token
                      }
      end
      
      def domain
        @domain ||= "https://sandbox.api.visa.com/"
      end
      
      def full_request_url
        @full_request_url ||= domain + base_uri + resource_path + "?" + query_string
      end
      
      def x_pay_token
        @x_pay_token ||= "xv2:" + timestamp + ":" + hash_output
      end
      
      def timestamp
        @time_stamp ||= "#{Time.now.to_i}"
      end
      
      def query_string
        @query_string ||= "apiKey=" + api_key
      end
      
      def shared_secret
        @shared_secret ||= "wC$4nph}qMT9r@8iVw}2vLk5Q9l1RIBzzic8bmvt".freeze
      end
      
      def base_uri
        @base_uri ||= 'cybersource/'.freeze
      end
      
      def api_key 
        @api_key ||= 'Y9O0XUY9GVVVYJZ82F5S21O4s4ZQkl-V__Uy8S0UPY9jbXN1M'.freeze
      end 
      
      def digest
        @digest ||= OpenSSL::Digest.new('sha256')
      end
    end
  end
end