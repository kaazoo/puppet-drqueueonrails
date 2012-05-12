class drqueueonrails::config {

  include ipython

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