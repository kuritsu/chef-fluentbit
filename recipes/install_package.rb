#
# Cookbook:: fluentbit
# Recipe:: install_package
#

# $ wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -

package 'gnupg2'

apt_repository 'fluentbit' do
  uri        "https://packages.fluentbit.io/#{node['platform']}/#{node['lsb']['codename']}"
  components ['main']
  key        'https://packages.fluentbit.io/fluentbit.key'
  keyserver  false
  only_if    platform_family?('debian') == 'true'
end

yum_repository 'fluentbit' do
  baseurl  'https://packages.fluentbit.io/centos/7/$basearch'
  gpgcheck true
  gpgkey   'https://packages.fluentbit.io/fluentbit.key'
  only_if  platform_family?('amazon', 'rhel') == 'true'
end

package 'td-agent-bit' do
  notifies :run, 'execute[Rename td-agent-bit dist config]', :immediately
end

# Rename the dist config file that will get replaced by our own
execute 'Rename td-agent-bit dist config' do
  action :nothing
  command 'mv td-agent-bit.conf td-agent-bit.conf.dist'
  cwd node['fluentbit']['conf_dir']
  not_if ::File.exist? "#{node['fluentbit']['conf_dir']}/td-agent-bit.conf.dist"
  only_if ::File.exist? "#{node['fluentbit']['conf_dir']}/td-agent-bit.conf"
end
