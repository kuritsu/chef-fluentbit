# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'fluentbit'

# Where to find external cookbooks:
default_source :supermarket

run_list 'fluentbit::default'

# Specify a custom source for a single cookbook:
cookbook 'fluentbit', path: '.'

named_run_list :install_example, 'recipe[fluentbit::install]', 'recipe[fluentbit::_example]'
