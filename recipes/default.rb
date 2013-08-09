#
# Cookbook Name:: candide
# Recipe:: default
#
# Copyright (C) 2013 Jeff Thomas
#
# All rights reserved - Do Not Redistribute
#

include_recipe "candide::nfs-support"
include_recipe "candide::webserver"
include_recipe "candide::ssh-key"
include_recipe "candide::database"
include_recipe "candide::ioncube"
include_recipe "candide::drush"
include_recipe "candide::solr"
include_recipe "candide::drupal"

