class drqueueonrails::install {

  # clone from git repository
  exec { "su -c \"git clone -b ${drqueueonrails::git_branch} git://github.com/kaazoo/DrQueueOnRails.git /home/drqueueonrails/DrQueueOnRails\" drqueueonrails":
    creates => "/home/drqueueonrails/DrQueueOnRails",
    path    => ["/bin", "/usr/bin", "/usr/sbin"],
    require => Package["git-core"],
  }

  # TODO:
  # notify about manual configuration steps
  # cd /home/drqueueonrails/DrQueueOnRails
  # bundle install

}
