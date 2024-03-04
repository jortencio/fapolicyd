# @summary A class for installing and configuring fapolicyd
#
# This class installs and configures fapolicyd
#
# @param package_ensure
#
#   Set the state of the package
# 
# @param service_ensure
#
#   Set the state of the service
#
# @param service_enable
#
#   Set whether the service is enabled/disabled
#
# @example
#   include fapolicyd
class fapolicyd (
  Enum['present', 'installed', 'absent'] $package_ensure = 'present',
  Enum['running', 'stopped']             $service_ensure = 'running',
  Boolean                                $service_enable = true,
) {
  package { 'fapolicyd':
    ensure => $package_ensure,
  }

  service { 'fapolicyd':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => Package['fapolicyd'],
  }
}
