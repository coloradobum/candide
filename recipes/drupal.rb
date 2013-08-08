node[:users].each do |user|

  template "/var/www/#{user['sitecode']}dv/public_html/drupal7.make" do
    source 'drupal7.make.erb'
    mode 0755
    owner "#{user['sitecode']}dv"
    group 'apache'
    not_if { File.exists?("/var/www/#{user['sitecode']}dv/public_html/sites/all")}
  end

  execute "drush" do
    command "cd /var/www/#{user['sitecode']}dv/public_html/; drush make drupal7.make --yes"
    user "root"
    not_if { File.exists?("/var/www/#{user['sitecode']}dv/public_html/sites/default/settings.php")}
  end

  execute "drush" do
      command "cd /var/www/#{user['sitecode']}dv/public_html/; \
      drush si --db-url=mysql://#{user['sitecode']}dv_drupal:#{user['sitecode']}dv_drupal@localhost/#{user['sitecode']}dv_drupal \
      --account-name=#{user['sitecode']}dv_drupal \
      --account-pass=#{user['sitecode']}dv_drupal \
      --db-su=root \
      --db-su-pw=rootpass \
      --site-name='#{user['sitecode']}dv' \
      --yes"
      user "root"
      not_if { File.exists?("/var/www/#{user['sitecode']}dv/public_html/sites/default/settings.php")}
  end

  execute "set-permissions" do
      command "cd /var/www/#{user['sitecode']}dv/; sudo chown -R #{user['sitecode']}dv:apache public_html"
      user "root"
  end

  execute "set-files-permissions" do
      command "cd /var/www/#{user['sitecode']}dv/public_html/sites/default; chmod -R 777 files"
      user "root"
  end

  # file "/var/www/#{user['sitecode']}dv/public_html/sites/default/settings.php" do
  #   mode "0444"
  #   action :touch
  #   owner "#{user['sitecode']}dv"
  #   group 'apache'
  # end

  template "/var/www/#{user['sitecode']}dv/public_html/sites/default/settings.php" do
    source 'settings.php.erb'
    owner "#{user['sitecode']}dv"
    group 'apache'
    variables({
      :sitecode => user['sitecode']
    })
  end

end
