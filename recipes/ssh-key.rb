#
# Cookbook Name:: candide
# Recipe:: default
#
# Copyright (C) 2013 Jeff Thomas
#
# All rights reserved - Do Not Redistribute
#

node[:users].each do |user|

  directory "/home/#{user['sitecode']}dv/.ssh"  do
    owner "#{user['sitecode']}dv"
    group "#{user['sitecode']}dv"
    mode 0700
    action :create
  end

  # template "/home/#{user['sitecode']}dv/.ssh/authorized_keys" do
  #   source "authorized_keys"
  #   owner "#{user['sitecode']}dv"
  #   group "#{user['sitecode']}dv"
  #   mode 0600
  #   action :create
  # end

  cookbook_file "/home/#{user['sitecode']}dv/.ssh/authorized_keys" do
    backup false
    source "authorized_keys"
    action :create
  end

end
