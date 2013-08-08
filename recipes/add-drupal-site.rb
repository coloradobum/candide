template node['drupal-app']['path'] + '/drupal7.make' do
  source 'drupal7.make.erb'
  mode 0755
  owner 'vagrant'
  group 'vagrant'
  not_if { File.exists?("/var/www/drupal/sites/all")}
end

execute "drush" do
  command "cd /var/www/drupal/; drush make drupal7.make --yes"
  #user "root"
  not_if { File.exists?("/var/www/drupal/sites/all")}
end

execute "drush" do
    command "cd /var/www/drupal/; \
    drush si --db-url=mysql://root:password@localhost/drupal \
    --account-name=drupal \
    --account-pass=drupal \
    --db-su=root \
    --db-su-pw=root \
    --site-name='drupal.dev' \
    --yes"
    user "root"
    not_if { File.exists?("/var/www/drupal/sites/default/settings.php")}
end
