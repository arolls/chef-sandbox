# # encoding: utf-8

# Inspec test for recipe nginx-docker::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command 'wget -qSO- --spider localhost' do
  its('stderr') { should match %r{HTTP/1\.1 200 OK} }
end

describe port 80 do
  it { should be_listening }
end
