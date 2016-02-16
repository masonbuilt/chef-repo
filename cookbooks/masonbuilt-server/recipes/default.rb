#
# Cookbook Name:: sendero
# Recipe:: default
#
# Copyright (C) 2016 MasonBuilt
#
# All rights reserved - Do Not Redistribute
#

#####################
# Misc dependencies #
#####################
include_recipe "apt::default"
include_recipe "yum"
include_recipe 'openssl'

##############
# Postgresql #
##############
# include_recipe 'postgresql'
# include_recipe 'postgresql::server'
# bash "assign-postgres-password" do
#   user 'postgres'
#   code <<-EOH
# echo "CREATE DATABASE sendero_dev;" | psql -p #{node['postgresql']['config']['port']}
# echo "ALTER DATABASE sendero_dev OWNER postgres;" | psql -p #{node['postgresql']['config']['port']}
#   EOH
#   action :run
# end

###########
# Sqlite3 #
###########
package 'libsqlite3-dev' do
  action :install
end

########
# Ruby #
########
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
rbenv_ruby "2.2.3" do
  ruby_version "2.2.3"
  global "2.2.3"
end

####################
# Rubygems/Bundler #
####################
include_recipe 'rubygems'
bash 'bundler-and-bash-profile-misc' do
  code <<-EOH
echo "gem: --user-install" >> /home/deploy/.gemrc
export PATH=/home/deploy/.gem/ruby/2.2.0/bin:$PATH
gem install bundler
  EOH
end

#########
# Nginx #
#########
include_recipe 'nginx'
template "/etc/nginx/sites-enabled/sendero" do
  source "nginx.conf.erb"
  action :create
end

#########
# Redis #
#########
# package 'redis-server' do
#   action :install
# end
# include_recipe 'redis'
# package 'redis-tools'

###########
# Unicorn #
###########
template "/etc/init.d/unicorn" do
  source "unicorn.erb"
  mode "0755"
  action :create
  owner "deploy"
end

#######
# SSH #
#######
template "/home/deploy/.ssh/config" do
  source "ssh-config.erb"
  action :create
end

##########
# NodeJS #
##########
package 'nodejs' do
  action :install
end

#####################
# Rest of the stuff #
#####################
bash "misc" do
  code <<-EOH
export PATH=/home/deploy/.gem/ruby/2.1.0/bin:$PATH
export PATH=/opt/rbenv/versions/2.1.2/bin:$PATH
  EOH
end
