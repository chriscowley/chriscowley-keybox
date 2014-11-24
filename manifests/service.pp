# == Class keybox::service
#
# This class is meant to be called from keybox.
# It ensure the service is running.
#
class keybox::service {

  service { $::keybox::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
