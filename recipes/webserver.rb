#
# Cookbook Name:: candide
# Recipe:: default
#
# Copyright (C) 2013 Jeff Thomas
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"

# disable default site
  apache_site "000-default" do
    enable false
  end

package "php-mysql" do
  action :install
  notifies :restart, "service[apache2]"
end

package "php-mbstring" do
  action :install
  notifies :restart, "service[apache2]"
end

package "php-dom" do
  action :install
  notifies :restart, "service[apache2]"
end

package "php-soap" do
  # action :install
  # options "--force-yes"
end


node[:users].each do |user|

  group user['sitecode'] do
    group_name [ user['sitecode'], "dv" ].join
  end

  user user['sitecode'] do
    group [ user['sitecode'], "dv" ].join
    username [ user['sitecode'], "dv" ].join
    comment "#{user['comment']}dv"
    supports :manage_home => true
    system true
    shell "/bin/bash"
    home "/home/#{user['sitecode']}dv"
  end

  # create apache config
  template "#{node[:apache][:dir]}/sites-available/#{user['sitecode']}dv.conf" do
    source "apache2.conf.erb"
    variables({
      :sitecode => user['sitecode']
    })
    notifies :restart, 'service[apache2]'
  end

  # create document root
  directory "/var/www/#{user['sitecode']}dv" do
    action :create
    recursive true
  end

  # create website folder
  template "/var/www/#{user['sitecode']}dv/index.php" do
    source "index.php.erb"
    mode "0644" # forget me to create debugging exercise
  end

  # enable website
  apache_site "#{user['sitecode']}dv.conf" do
    enable true
  end

end
