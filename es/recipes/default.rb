#
# Cookbook Name:: es
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Create elasticsearch user
elasticsearch_user 'elasticsearch' do
  username 'elasticsearch'
  groupname 'elasticsearch'
  shell '/bin/bash'
  comment 'Elasticsearch User'
  action :create
end

elasticsearch_install 'elasticsearch' do
  type :package
  version "1.7.2"
  action :install
end

elasticsearch_configure 'elasticsearch' do
    allocated_memory '256m'
    configuration ({
      'cluster.name' => 'mycluster',
      'node.name' => 'node01'
    })
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end

elasticsearch_plugin 'head' do
  url 'mobz/elasticsearch-head'
  notifies :restart, 'elasticsearch_service[elasticsearch]', :delayed
end
