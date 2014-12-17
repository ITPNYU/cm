node "default" {
  package { "git":
    name => "git",
    ensure => "installed"
  }
}
