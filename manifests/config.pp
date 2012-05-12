class drqueueonrails::config {

  package { "git-core":
    ensure => present,
  }

  group { "drqueueonrails":
    ensure => "present",
  }

  user { "drqueueonrails":
    ensure     => present,
    gid        => "drqueueonrails",
    home       => "/home/drqueueonrails",
    managehome => true,
    shell      => "/bin/bash",
    require    => Group["drqueueonrails"]
  }


}