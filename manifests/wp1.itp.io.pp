class { 'apache':
  default_vhost => false,
  mpm_module => 'prefork',
  serveradmin => 'helpdesk@itp.nyu.edu',
  server_signature => 'Off',
}

class { '::apache::mod::php': }
class { '::apache::mod::rewrite': }

apache::vhost { 'wp1':
  docroot => '/var/www',
  directories => [
    { path => '/var/www',
      allow_override => ['None'],
      options => ['Indexes', 'FollowSymLinks', 'MultiViews'],
    },
    { path => '/var/www/thesis',
      allow_override => ['All'],
      options => ['Indexes', 'FollowSymLinks', 'MultiViews'],
    },
    { path => '/var/www/thesistest',
      allow_override => ['All'],
      options => ['Indexes', 'FollowSymLinks', 'MultiViews'],
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

include '::mysql::server'
include '::mysql::server::account_security'
include '::mysql::client'
class { 'mysql::bindings':
  php_enable => true
}

package {'libssh2-php': ensure => 'installed' }
package {'php5-gd': ensure => 'installed' }
package {'php-http-request2': ensure => 'installed' }
package {'postfix': ensure => 'installed' }
