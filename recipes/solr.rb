pkgs = ["wget"]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe "java"

remote_file "/usr/local/src/apache-solr-3.6.2.tgz" do
  #source "http://apache.mirrors.hoobly.com/lucene/solr/3.6.2/apache-solr-3.6.2.tgz"
  source "https://dl.dropboxusercontent.com/u/250764/apache-solr-3.6.2.tgz"
  mode "0644"
  action :create_if_missing
  notifies :run, "script[extract_apache_solr]", :immediately
end

script "extract_apache_solr" do
  interpreter "bash"
  user "root"
  cwd "/usr/local/src/"
  action :nothing
  code <<-EOH
  tar xvfz /usr/local/src/apache-solr-3.6.2.tgz
  ln -s  /usr/local/src/apache-solr-3.6.2 /usr/local/bin/apache-solr
  EOH
end

execute "mv" do
  cmd = "mv /usr/local/bin/apache-solr/example /usr/local/bin/apache-solr/drupal"
  command <<-EOF
    #{cmd}
    EOF
  only_if { ! ::File.exists?("/usr/local/bin/apache-solr/drupal") }
end

template "/usr/local/bin/apache-solr/drupal/solr/solr.xml" do
  source "solr.xml.erb"
  variables({
      :sitecode => "abc" #TODO make this autofill
    })
end

remote_directory "/usr/local/bin/apache-solr/drupal/solr/core_template_d7" do
  files_backup false
  source "core_template_d7"
  action :create_if_missing
end

node[:users].each do |user|
  execute "cp -r" do
    cmd = "cp -r /usr/local/bin/apache-solr/drupal/solr/core_template_d7 \
                /usr/local/bin/apache-solr/drupal/solr/#{user['sitecode']}"
    command <<-EOF
      #{cmd}
    EOF
    only_if { ! ::File.exists?("/usr/local/bin/apache-solr/drupal/solr/#{user['sitecode']}") }
  end
end

template "solr.start" do
  path "/usr/local/bin/apache-solr/solr.start"
  source "solr.start.erb"
  mode 0700
  action :create_if_missing
end

template "solr.conf" do
  path "/etc/solr.conf"
  source "solr.conf.erb"
  action :create_if_missing
end
template "solr" do
  path "/etc/init.d/solr"
  source "solr.erb"
  owner "root"
  group "root"
  mode "0755"
  notifies :enable, "service[solr]"
  notifies :start, "service[solr]"
end

service "solr" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :start
end
