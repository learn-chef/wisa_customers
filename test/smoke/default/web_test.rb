# # encoding: utf-8

# Inspec test for recipe wisa_customers::web

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe command 'Get-WebAppPoolState -Name Products' do
  its('stdout') { should match /Started/ }
end

describe command 'Get-Website' do
  its('stdout') { should match /Customers/ }
  its('stdout') { should match /Started/ }
end

describe command 'Get-WebApplication' do
  its('stdout') { should match /Products/ }
  its('stdout') { should match /http/ }
end

describe command '(Invoke-WebRequest -UseBasicParsing localhost).StatusCode' do
  its('stderr') { should match /403/ }
end

describe command '(Invoke-WebRequest -UseBasicParsing localhost/Products/Customers.aspx).StatusCode' do
  its('stdout') { should match /200/ }
end
