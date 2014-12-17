node "itp.io" {

  package { "postfix":
    name => "postfix",
    ensure => "installed"
  }

  package { "pound":
    name => "pound",
    ensure => "installed"
  }
}
