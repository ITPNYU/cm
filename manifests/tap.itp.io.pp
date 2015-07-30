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
      allow_override => ['None'],
    },
    { path => '/var/www/html/tap',
      allow_override => ['All'],
    },
  ],
  servername => 'itp.io',
  ssl => true,
  ssl_cert => '/etc/ssl/private/www.itp.io.crt',
  ssl_chain => '/etc/ssl/private/www.itp.io.pem',
  ssl_key => '/etc/ssl/private/www.itp.io.key',
  vhost_name => '*',
  port => '443',
}

group { 'ssl-cert':
  name => 'ssl-cert',
  ensure => 'present',
}

user { 'www-data':
  name => 'www-data',
  membership => 'minimum',
  groups => 'ssl-cert',
  require => Package['apache2'],
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

package {'php5-gd': ensure => 'installed' }
package {'postfix': ensure => 'installed' }
