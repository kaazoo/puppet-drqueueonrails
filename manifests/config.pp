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

  file { "/etc/apache2/sites-available/dqor":
    ensure => present,
    owner   => "root",
    group   => "root",
    mode    => 644,
    source  => "puppet:///modules/drqueueonrails/vhost.conf",
  }

  exec { "/usr/sbin/a2enmod ssl headers expires":
    refreshonly => true,
    subscribe => File["/etc/apache2/sites-available/dqor"],
    alias => "a2enmod-ssl",
  }

  exec { "/usr/sbin/a2ensite dqor":
    refreshonly => true,
    subscribe => Exec["a2enmod-ssl"],
    notify => Exec["/etc/init.d/apache2 restart"],
  }

  file { "/etc/profile.d/drqueue.sh":
    ensure => present,
    owner   => "root",
    group   => "root",
    mode    => 755,
    source  => "puppet:///modules/drqueueonrails/drqueue.sh",
  }

}