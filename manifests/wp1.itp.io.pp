class { 'apache':
  mpm_module => 'prefork'
}
class { '::apache::mod::php': }
include '::apache::mod::rewrite'

include '::mysql::server'
include '::mysql::server::account_security'
include '::mysql::client'
class { 'mysql::bindings':
  php_enable => true
}

package {'libssh2-php': ensure => 'installed' }
package {'php5-gd': ensure => 'installed' }
