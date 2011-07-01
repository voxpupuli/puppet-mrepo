mrepo::repo { "centos5-i386":
  ensure    => present,
  update    => "weekly",
  repotitle => "CentOS 5.6 32 bit",
  arch      => "i386",
  release   => "5.6",
  urls      => {
    addons      => 'rsync://mirrors.kernel.org/centos/$release/addons/$arch/',
    centosplus  => 'rsync://mirrors.kernel.org/centos/$release/centosplus/$arch/',
    contrib     => 'rsync://mirrors.kernel.org/centos/$release/contrib/$arch/',
    extras      => 'rsync://mirrors.kernel.org/centos/$release/extras/$arch/',
    fasttrack   => 'rsync://mirrors.kernel.org/centos/$release/fasttrack/$arch/',
    updates     => 'rsync://mirrors.kernel.org/centos/$release/updates/$arch/',
  }
}
