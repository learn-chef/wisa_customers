name 'wisa_customers'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures wisa_customers'
long_description 'Installs/Configures wisa_customers'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/learn-chef/wisa_customers/issues' if respond_to?(:issues_url)
source_url 'https://github.com/learn-chef/wisa_customers' if respond_to?(:source_url)
supports 'windows'

depends 'wisa'
depends 'iis', '~> 6.5.2'
