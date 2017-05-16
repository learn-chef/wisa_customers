#
# Cookbook:: wisa_customers
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'wisa::default'
include_recipe 'wisa_customers::web'
include_recipe 'wisa_customers::database'
