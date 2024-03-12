# @summary A type for managing fapolicyd trust files
#
# A type for managing fapolicyd trust files under `/etc/fapolicyd/trust.d/`
#
# @param trusted_apps
#
#  An array of the absolute path of applications to trust
#
# @example
#   fapolicyd::trust_file { 'myapp':
#     trusted_apps => [
#       '/tmp/ls',
#     ],
#   }
define fapolicyd::trust_file (
  Array[Stdlib::Absolutepath] $trusted_apps = []
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
      match  => "^${trusted_app}|^#${trusted_app}",
      notify => Service['fapolicyd'],
    }
  }
}
