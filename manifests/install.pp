# == Class keybox::install
#
# This class is called from keybox for install.
#
class keybox::install {

  package { $::keybox::package_name:
    ensure => present,
  }
}
