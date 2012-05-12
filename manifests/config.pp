class drqueueonrails::config {

  include ipython
  include rvm

  rvm_system_ruby { "ruby-1.8.7-p358":
    ensure => present,
    default_use => true,
  }

  rvm_gem { "bundler":
    ruby_version => "ruby-1.8.7-p358",
    ensure => latest,
    require => Rvm_system_ruby["ruby-1.8.7-p358"],
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

  rvm::system_user { "drqueueonrails":
    require => User["drqueueonrails"],
  }

}