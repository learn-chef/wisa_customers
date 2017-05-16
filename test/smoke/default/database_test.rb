# # encoding: utf-8

# Inspec test for recipe wisa_customers::database

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe command 'Invoke-Sqlcmd -Query "SELECT name FROM sys.databases"' do
  its('stdout') { should match /learnchef/ }
end

describe command 'Invoke-Sqlcmd -Database learnchef -Query "SELECT id,first_name FROM customers"' do
  its('stdout') { should match /Jane/ }
end

describe command %q(Invoke-Sqlcmd -Database learnchef -Query "EXEC sp_helprotect @username = 'IIS APPPOOL\Products', @name = 'customers'") do
  its('stdout') { should match /IIS APPPOOL\\Products/ }
  its('stdout') { should match /Grant/ }
  its('stdout') { should match /Select/ }
end
