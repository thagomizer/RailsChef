#
# Cookbook Name:: blog
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'runit'

package 'nodejs' # for javascript runtime

mysql_connection_info = {
  :host => 'localhost',
  :username => 'root',
  :password => 'password',
  :socket   => '/run/mysql-default/mysqld.sock'
}

mysql2_chef_gem "default" do
  action :install
end

mysql_service 'default' do
  version '5.5'
  initial_root_password 'password'
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end

mysql_database "blog_production" do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'blog' do
  connection mysql_connection_info
  password ''
  database_name "blog_production"
  action :grant
end

# runit_service "blog" do
#   default_logger true
# end

# we define our application using application resource provided by application cookbook
application 'blog' do
  path '/usr/local/www/blog'
  revision 'master'
  repository 'git@github.com:thagomizer/examples-rails-blog.git'
  deploy_key '/home/ajahammerly/.ssh/id_rsa'
  migrate true
  rails do
    bundler true
    database do
      host 'localhost'
      username mysql_connection_info[:username]
      password mysql_connection_info[:password]
      database 'blog_production'
      adapter 'mysql2'
      encoding 'utf8'
    end
  end
  unicorn do
    preload_app true
    worker_timeout 30
    worker_processes 2
  end
end
