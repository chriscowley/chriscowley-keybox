# == Class keybox::params
#
# This class is meant to be called from keybox.
# It sets variables according to platform.
#
class keybox::params {
  $manage_java = false
  $user        = 'keybox'
  $group       = 'keybox'
  $installdir  = '/opt/keybox'
  $url         = 'https://github.com/skavanagh/KeyBox/releases/download/v2.50.00/keybox-jetty-v2.50_00.tar.gz'
  case $::osfamily {
    'Debian': {
      $service_name = 'keybox'
    }
    'RedHat', 'Amazon': {
      $service_name = 'keybox'
      case $::operatingsystem {
        'Centos', 'RedHat': {
          if $::operatingsystemrelease < 7 {
            $initsystem = 'sysv'
          } else {
            $initsystem = 'systemd'
          }
        }
        'Fedora': {
          if $::operatingsystemrelease < 17 {
            $initsystem = 'sysv'
          } else {
            $initsystem = 'systemd'
          }
        }
        default: {
          fail("${::operatingsystem} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
