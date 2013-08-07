#
# Cookbook Name:: candide
# Recipe:: default
#
# Copyright (C) 2013 Jeff Thomas
#
# All rights reserved - Do Not Redistribute
#

default[:candide][:database][:host] = 'localhost'
default[:candide][:database][:username] = 'root'
default[:candide][:database][:password] = node[:mysql][:server_root_password]
