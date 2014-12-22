class { 'apache': }

include '::mysql::server'
include '::mysql::server::account_security'
include '::mysql::client'
