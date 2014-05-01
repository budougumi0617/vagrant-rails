# スワップ領域作成
# 参考:http://qiita.com/naoya@github/items/2059e3755962e907315e
bash 'create swapfile' do
  user 'root'
  code <<-EOC
    dd if=/dev/zero of=/swap.img bs=1M count=1024 &&
    chmod 600 /swap.img
    mkswap /swap.img
  EOC
  only_if "test ! -f /swap.img -a `cat /proc/swaps | wc -l` -eq 1"
end

mount '/dev/null' do # swap file entry for fstab
  action :enable # cannot mount; only add to fstab
  device '/swap.img'
  fstype 'swap'
end

bash 'activate swap' do
  code 'swapon -ae'
  only_if "test `cat /proc/swaps | wc -l` -eq 1"
end

# iptables無効
service "iptables" do
	action [:stop, :disable]
end

yum_package "yum-fastestmirror" do
  action :install
end

# yumの更新
execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

# yum関係
%w{gcc gcc-c++ make wget telnet readline-devel ncurses-devel gdbm-devel openssl-devel libxslt-devel sqlite-devel ruby-devel vim}.each do |p|
	package p do
		action :install
	end
end

# 設定の追記
bash 'update resolv.conf' do
  user 'root'
  code <<-EOC
    echo "options single-request-reopen" >> /etc/resolv.conf
  EOC
end

