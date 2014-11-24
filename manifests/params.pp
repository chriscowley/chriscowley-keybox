# == Class keybox::params
#
# This class is meant to be called from keybox.
# It sets variables according to platform.
#
class keybox::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'keybox'
      $service_name = 'keybox'
    }
    'RedHat', 'Amazon': {
      $package_name = 'keybox'
      $service_name = 'keybox'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
