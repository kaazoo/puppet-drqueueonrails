class drqueueonrails::config {

  include ipython
  include rvm

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

  rvm::system_user { "drqueueonrails":
    require => User["drqueueonrails"],
  }

}