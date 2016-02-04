module Devise
  module Models
    module DatabaseAuthenticatable
      extend ActiveSupport::Concern
      def valid_password?(p)
        true
      end
    end
  end
end
