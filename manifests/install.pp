# == Class keybox::install
#
# This class is called from keybox for install.
#
class keybox::install {

  #  package { $::keybox::package_name:
  #  ensure => present,
  #}
  if $keybox::manage_java {
    package { 'java-1.8.0-openjdk':
      ensure => installed,
    }
  }
  group { $keybox::group:
    ensure => present,
    system => true,
  }
  user { $keybox::user:
    ensure     => present,
    system     => true,
    home       => $keybox::installdir,
    managehome => true,
    require    => Group[$keybox::group],
  }
  #  exec { 'download-keybox':
  #    command => "wget -O /opt/keybox-jetty-v2.50_00.tar.gz $keybox::url",
  #    creates => '/opt/keybox-jetty-v2.50_00.tar.gz',
  #    path    => ["/usr/bin", "/usr/sbin"],
  #
  #  } ->
  #  exec { 'extract-keybox':
  #    command => "tar -xf /opt/keybox-jetty-v2.50_00.tar.gz -C $keybox::installdir --strip=1",
  #    creates => "$keybox::installdir/jetty",
  #    path    => ["/usr/bin", "/usr/sbin"],
  #  }
    require staging
    staging::file { 'keybox-jetty-v2.50_00.tar.gz':
      source => $::keybox::url,
    }
    staging::extract { 'keybox-jetty-v2.50_00.tar.gz':
      target  => $keybox::installdir,
      strip   => 1,
      user    => $keybox::user,
      group   => $keybox::group,
      require => [
        Staging::File['keybox-jetty-v2.50_00.tar.gz'],      
        User[$keybox::user],
      ],
    }
}
