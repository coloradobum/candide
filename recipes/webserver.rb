include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "php::module_mysql"
include_recipe "php::module_gd"

pkgs = ["php-mysql", "php-mbstring", "php-dom", "php-soap"]
pkgs.each do |pkg|
  package pkg do
    action :install
    notifies :restart, "service[apache2]"
  end
end

# # disable default site
#   apache_site "000-default" do
#     enable false
#   end

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
  directory "/var/www/#{user['sitecode']}dv/"  do
    group [ user['sitecode'], "dv" ].join
    owner [ user['sitecode'], "dv" ].join
    mode "0775"
    action :create
  end

  directory "/var/www/#{user['sitecode']}dv/public_html" do
    action :create
    #recursive true
    mode "0775"
    owner "#{user['sitecode']}dv"
    group "apache"
  end

  execute "symlink" do
    command "ln -s /var/www/#{user['sitecode']}dv/ /home/#{user['sitecode']}dv/www"
    not_if { File.exists?("/home/#{user['sitecode']}dv/www")}
  end

  # # create website folder
  # template "/var/www/#{user['sitecode']}dv/public_html/index.php" do
  #   source "index.php.erb"
  #   mode "0664" # forget me to create debugging exercise
  #   owner "#{user['sitecode']}dv"
  #   group "apache"
  # end

  # enable website
  apache_site "#{user['sitecode']}dv.conf" do
    enable true
  end

end
