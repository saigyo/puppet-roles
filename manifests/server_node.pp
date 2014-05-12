class roles::server_node {
  include profiles::java7
  include profiles::mysql
  include profiles::mongodb
  include profiles::nodejs
  
  group { 'everest':
    name   => 'everest',
    ensure => present,
    gid    => 222
  }

  user { 'everest':
    require => Group['everest'],
    name    => 'everest',
    ensure  => present,
    gid     => 'everest',
    groups  => ['users','syslog'],
    home    => '/mnt/everest',
    system  => true
  }

  file { '/mnt/everest':
    require => User['everest'],
    path    => '/mnt/everest',
    ensure  => directory,
    owner   => 'everest',
    group   => 'everest'
  }

  file { '/home/everest':
    require => File['/mnt/everest'],
    ensure  => link,
    target  => '/mnt/everest',
    force   => true
  }
  
  group { 'ubuntu':
    name   => 'everest',
    ensure => present,
    gid    => 1000
  }

  user { 'ubuntu':
    require => Group['ubuntu'],
    name    => 'ubuntu',
    uid     => 1000,
    gid     => 'ubuntu',
    groups  => ['ubuntu','adm'],
    home    => '/home/ubuntu',
    system  => true,
    ensure  => present
  }

  file { '/home/ubuntu':
    require => User['ubuntu'],
    path    => '/home/ubuntu',
    ensure  => directory,
    owner   => 'ubuntu',
    group   => 'ubuntu'
  }
}