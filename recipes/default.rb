#
# Cookbook:: fluentbit
# Recipe:: default
#

include_recipe 'fluentbit::install'

if node['fluentbit']['forward']['enabled']
  include_recipe 'fluentbit::forward'
end

if node['fluentbit']['mail']['enabled']
  include_recipe 'fluentbit::mail'
end
