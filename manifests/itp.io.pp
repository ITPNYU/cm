node "itp.io" {

  package { "postfix":
    name => "postfix",
    ensure => "installed"
  }
}
