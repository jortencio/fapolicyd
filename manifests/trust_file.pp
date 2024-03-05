# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @param trusted_apps
#
# @example
#   fapolicyd::trust_file { 'namevar': }
define fapolicyd::trust_file (
  Array $trusted_apps = []
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
    if Deferred('fapolicyd::file_exists', [$trusted_app]) {
      $file_size = Deferred('fapolicyd::file_size', [$trusted_app])
      $file_sha256 = Deferred('fapolicyd::file_sha256', [$trusted_app])

      file_line { "${title}_${trusted_app}":
        ensure => present,
        path   => $trusted_file_path,
        line   => "${trusted_app} ${file_size} ${file_sha256}",
        match  => "^${trusted_app}",
        notify => Service['fapolicyd'],
      }
    } else {
      notify { "Unable to add '${trusted_app}'' to trust file '${title}', the file does not exist": }
    }
  }
}
