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
  $service_name = $::keybox::params::service_name,
  $user         = $::keybox::params::user,
  $group        = $::keybox::params::group,
  $installdir   = $::keybox::params::installdir,
  $url          = $::keybox::params::url,
  $manage_java  = $::keybox::params::manage_java,
  $initsystem   = $::keybox::params::initsystem,
) inherits ::keybox::params {

  # validate parameters here

  class { '::keybox::install': } ->
  class { '::keybox::config': } ~>
  class { '::keybox::service': } ->
  Class['::keybox']
}
