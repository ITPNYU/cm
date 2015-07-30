# install the puppetlabs-apache and puppetlabs-mysql modules, e.g.
# puppet module install puppetlabs-apache 
# puppet module install puppetlabs-mysql

class { 'apache':
  default_vhost => false,
  mpm_module => 'prefork',
  serveradmin => 'helpdesk@itp.nyu.edu',
  server_signature => 'Off',
}

class { '::apache::mod::php': }
class { '::apache::mod::rewrite': }

apache::vhost { 'tap':
  docroot => '/var/www/html',
  directories => [
    { path => '/var/www/html',
      allow_override => ['All'],
    },
  ],
  servername => 'tap.itp.io',
  ssl => true,
  ssl_cert => '/etc/ssl/private/www.itp.io.crt',
  ssl_chain => '/etc/ssl/private/www.itp.io.pem',
  ssl_key => '/etc/ssl/private/www.itp.io.key',
  vhost_name => '*',
  port => '443',
}

# you have to manually add user www-data to ssl-cert group
group { 'ssl-cert':
  name => 'ssl-cert',
  ensure => 'present',
}

file { '/etc/ssl/private':
  path => '/etc/ssl/private',
  ensure => 'directory',
  owner => 'root',
  group => 'ssl-cert',
  require => Group['ssl-cert'],
}

file { '/etc/ssl/private/www.itp.io.crt':
  path => '/etc/ssl/private/www.itp.io.crt',
  ensure => 'present',
  mode => '0444',
}

file { '/etc/ssl/private/www.itp.io.key':
  path => '/etc/ssl/private/www.itp.io.key',
  ensure => 'present',
  mode => '0440',
}

file { '/etc/ssl/private/www.itp.io.pem':
  path => '/etc/ssl/private/www.itp.io.pem',
  ensure => 'present',
  mode => '0444',
}

file { '/etc/ssl/private/DigiCertCA.crt':
  path => '/etc/ssl/private/DigiCertCA.crt',
  ensure => 'present',
  mode => '0444',
}

include '::mysql::server'
include '::mysql::server::account_security'
include '::mysql::client'
class { 'mysql::bindings':
  php_enable => true
}

package {'php5-curl': ensure => 'installed' }
package {'php5-gd': ensure => 'installed' }
package {'postfix': ensure => 'installed' }
