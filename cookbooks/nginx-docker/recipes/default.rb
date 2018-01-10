#
# Cookbook:: nginx-docker
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Pull latest image

apt_update 'daily' do
  frequency 86_400
  action :periodic
end

docker_service 'default' do
  action [:create, :start]
end

docker_image 'busybox' do
  action :pull
end

docker_container 'an-echo-server' do
  repo 'busybox'
  port '1234:1234'
  command "nc -ll -p 1234 -e /bin/cat"
end

docker_image 'nginx' do
  tag 'latest'
  action :pull
end

# Run container exposing ports
docker_container 'nginxpiece' do
  repo 'nginx'
  tag 'latest'
  port '80:80'
  host_name 'nginx-server'
  volumes "/tmp/web-piece/:/usr/share/nginx/html/"
  subscribes :redeploy, 'docker_image[nginx]'
end

# Write the home page.
template "/tmp/web-piece/index.html" do
  source 'index.html.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action [ :create_if_missing, :create ]
end
