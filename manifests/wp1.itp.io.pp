class { 'apache': }

include '::mysql::server'
include '::mysql::server::account_security'
include '::mysql::client'

package {'libssh2-php': ensure => 'installed' }
package {'php5-gd': ensure => 'installed' }
