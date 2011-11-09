require 'user'

module AccountManagerPlugin
  module UserPatch
    def self.included(base) # :nodoc:    
      base.send(:include, InstanceMethods)     
      base.class_eval do      
        unloadable
        alias_method_chain :validate, :other_policy
      end
    end
    module InstanceMethods    
      def validate_with_other_policy
        # デフォルトの制限 = 4文字以上を許可
        validate_without_other_policy

        # 英数+記号のみを許可
        unless password =~ /^[a-z0-9_\-@\.]*$/i
          errors.add(:password, :digit_and_alpha) 
        end
        
        # 大文字小文字の英字および数字が混在している場合のみを許可
        unless (password =~ /[a-z]+/ && password =~ /[A-Z]+/ && password =~ /[0-9]+/)   
          errors.add(:password, :complexity)
        end
      end
    end
  end
end

::User.send(:include, AccountManagerPlugin::UserPatch)
