node "itp.io" {

  package { "nginx":
    name => "nginx",
    ensure => "installed"
  }

  package { "postfix":
    name => "postfix",
    ensure => "installed"
  }

  package { "pound":
    name => "pound",
    ensure => "installed"
  }

  package { "varnish":
    name => "varnish",
    ensure => "installed"
  }
}
