class { 'apache':
  default_vhost => false,
  mpm_module => 'prefork',
  serveradmin => 'helpdesk@itp.nyu.edu',
  servername => 'itp.io',
  server_signature => 'Off',
}

class { '::apache::mod::php': }
class { '::apache::mod::rewrite': }

apache::vhost { '*:80':
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
  ],
}

include '::mysql::server'
include '::mysql::server::account_security'
include '::mysql::client'
class { 'mysql::bindings':
  php_enable => true
}

package {'libssh2-php': ensure => 'installed' }
package {'php5-gd': ensure => 'installed' }
