drush_channel = php_pear_channel "pear.drush.org" do
   action :discover
   not_if { File.exists?("/usr/local/drush")}
 end

 php_pear "drush" do
   channel drush_channel.channel_name
   action :install
   not_if { File.exists?("/usr/local/drush")}
end

execute "drush" do
    command "drush"
    user "root"
    not_if { File.exists?("/usr/local/drush")}
end
