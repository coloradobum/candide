#
# Cookbook Name:: candide
# Recipe:: default
#
# Copyright (C) 2013 Jeff Thomas
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"
include_recipe "database::mysql"

node[:users].each do |user|

  mysql_database [ user['sitecode'], "dv_drupal" ].join do
    connection(
      :host     => node[:candide][:database][:host],
      :username => node[:candide][:database][:username],
      :password => node[:candide][:database][:password]
    )
    action :create
  end

  mysql_database_user [user['sitecode'], "dv_drupal"].join do
    connection(
      :host     => node[:candide][:database][:host],
      :username => node[:candide][:database][:username],
      :password => node[:candide][:database][:password]
    )
    password      [user['sitecode'], "dv_drupal"].join
    database_name [user['sitecode'], "dv_drupal"].join
    host node[:candide][:database][:host]
    action [:create, :grant]
  end

end
