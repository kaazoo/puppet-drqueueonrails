class drqueueonrails::install {

  include rvm

  # install specific Ruby version with RVM
  rvm_system_ruby { "ruby-${drqueueonrails::ruby_version}":
    ensure => present,
    default_use => true,
  }

  # install bundler gem
  rvm_gem { "bundler":
    ruby_version => "ruby-${drqueueonrails::ruby_version}",
    ensure => latest,
    require => Rvm_system_ruby["ruby-${drqueueonrails::ruby_version}"],
  }

  # install passenger gem
  class { "rvm::passenger::apache":
    version => $drqueueonrails::passenger_version,
    ruby_version => "ruby-${drqueueonrails::ruby_version}",
    mininstances => "3",
    maxinstancesperapp => "0",
    maxpoolsize => "30",
    spawnmethod => "smart-lv2",
  }

  # restart apache after passenger config file is created
  exec { "/etc/init.d/apache2 restart":
    refreshonly => true,
    subscribe => File["/etc/apache2/mods-available/passenger.conf"],
  }

  # clone from git repository
  exec { "su -c \"git clone -b ${drqueueonrails::git_branch} git://github.com/kaazoo/DrQueueOnRails.git /home/drqueueonrails/DrQueueOnRails\" drqueueonrails":
    creates => "/home/drqueueonrails/DrQueueOnRails",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
    require => Package["git-core"],
    notify  => Exec["bundle-install"],
  }

  # install gems
  exec { "su -c \"bundle install\" drqueueonrails":
    cwd         => "/home/drqueueonrails/DrQueueOnRails",
    path        => ["/bin", "/usr/bin", "/usr/sbin"],
    refreshonly => true,
    alias       => "bundle-install",
  }

  # TODO:
  # notify about manual configuration steps


}
