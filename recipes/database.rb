#
# Cookbook:: wisa_customers
# Recipe:: database
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# Create a path to the SQL file in the Chef cache.
create_database_script_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'create-database.sql'))

# Copy the SQL file from the cookbook to the Chef cache.
cookbook_file create_database_script_path do
  source 'create-database.sql'
end

# Run the SQL file only if the 'learnchef' database has not yet been created.
powershell_script 'Initialize database' do
  code <<-EOH
    Invoke-Sqlcmd -Verbose -InputFile #{create_database_script_path}
  EOH
  guard_interpreter :powershell_script
  only_if <<-EOH
    (Invoke-Sqlcmd -Query "SELECT COUNT(*) AS Count FROM sys.databases WHERE name = 'learnchef'").Count -eq 0
  EOH
end

# Create a path to the SQL file in the Chef cache.
grant_access_script_path = win_friendly_path(File.join(Chef::Config[:file_cache_path], 'grant-access.sql'))

# Copy the SQL file from the cookbook to the Chef cache.
cookbook_file grant_access_script_path do
  source 'grant-access.sql'
end

# Run the SQL file only if IIS APPPOOL\Products does not have access.
powershell_script 'Grant SQL access to IIS APPPOOL\Products' do
  code <<-EOH
    Invoke-Sqlcmd -InputFile #{grant_access_script_path}
  EOH
  guard_interpreter :powershell_script
  not_if <<-EOH
    $sp = Invoke-Sqlcmd -Database learnchef -Query "EXEC sp_helprotect @username = 'IIS APPPOOL\\Products', @name = 'customers'"
    ($sp.ProtectType.Trim() -eq 'Grant') -and ($sp.Action.Trim() -eq 'Select')
  EOH
end
