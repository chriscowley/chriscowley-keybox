# == Class: keybox
#
# Full description of class keybox here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class keybox (
  $package_name = $::keybox::params::package_name,
  $service_name = $::keybox::params::service_name,
) inherits ::keybox::params {

  # validate parameters here

  class { '::keybox::install': } ->
  class { '::keybox::config': } ~>
  class { '::keybox::service': } ->
  Class['::keybox']
}
