# Class: bind::service
#
class bind::service (
  $servicename,
  $service_reload,
) inherits ::bind::params {

  if $service_reload {
    $servicecmd = case $facts['os']['family'] ? {
      'Gentoo' => 'rc-service',
      default  => 'service',
    }
    Service[$servicename] {
      restart => "${servicecmd} ${servicename} reload",
    }
  }

  service { $servicename:
    ensure    => 'running',
    enable    => true,
    hasstatus => true,
    require   => Class['bind::package'],
  }

}
