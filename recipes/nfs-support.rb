package "nfs-utils" do
  action :install
end

execute "chkconfig rpcbind" do
    command "chkconfig rpcbind on"
    user "root"
end

execute "chkconfig nfslock" do
    command "chkconfig nfslock on"
    user "root"
end
