require 'redmine'
require_dependency 'account_controller' 

class AccountController < ApplicationController
  def self.password_change_notify
    # 3ヶ月間ユーザー情報に変化がなければ、パスワードを強制更新
    users = User.find(:all, 
                      :conditions => ["updated_on < ? and status = 1 and auth_source_id is null", 
                                      Time.now - 3.month]
                      )
    
    users.each do |user|
      updated_user = user.random_password
      if updated_user.save
        Mailer.deliver_account_information(updated_user, updated_user.password)
      end
    end
  end
end
