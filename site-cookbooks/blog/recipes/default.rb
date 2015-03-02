## default.rb

user = node[:deploy_user]

directory "/var/www/" do
  owner user
  group user
  recursive true
end

## rails_nginx_unicorn_app.rb

include_recipe "rails_nginx_unicorn"

rails_nginx_unicorn_app node[:server_name] do
  app_root node[:deploy_to]
  deploy_user node[:deploy_user]
  deploy_group node[:deploy_group]
  server_names node[:server_name]
  http_port node[:http_port]
  https_port node[:https_port]
  name node[:application_name]
  rails_env node[:application_env]
  enabled true
end
