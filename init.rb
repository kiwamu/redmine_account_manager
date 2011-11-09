require 'redmine'
require 'user_patch'

Redmine::Plugin.register :redmine_account_manager do
  name 'Redmine Account Manager plugin'
  author 'Kato Kiwamu'
  description "This is a plugin for Redmine's account managemant."
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
