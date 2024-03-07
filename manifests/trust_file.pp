# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @param trusted_apps
#
# @example
#   fapolicyd::trust_file { 'namevar': }
define fapolicyd::trust_file (
  Array[String[1]] $trusted_apps = []
) {
  $trusted_file_path = "/etc/fapolicyd/trust.d/${title}"

  file { $trusted_file_path:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['fapolicyd'],
  }

  $trusted_apps.each | String $trusted_app | {
    file_line { "${title}_${trusted_app}":
      ensure => present,
      path   => $trusted_file_path,
      line   => Deferred('fapolicyd::get_trusted_file_info', [$trusted_app]),
      match  => "^${trusted_app}|^# ${trusted_app}",
      notify => Service['fapolicyd'],
    }
  }
}
