# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @param priority
#
#
#
# @param comment
#
#
#
# @param rules
#
#
#
# @example
#   fapolicyd::rule_file { 'namevar': }
define fapolicyd::rule_file (
  Integer[0]             $priority = 100,
  String[1]              $comment = "${priority}-${title}.rules",
  Array[Fapolicyd::Rule] $rules = [],
) {
  $rule_file_path = "/etc/fapolicyd/rules.d/${priority}-${title}.rules"

  file { $rule_file_path:
    ensure  => file,
    owner   => 'root',
    group   => 'fapolicyd',
    mode    => '0644',
    content => epp('fapolicyd/fapolicyd.rules.epp', {
        comment => $comment,
        rules   => $rules,
    }),
    require => Package['fapolicyd'],
    notify  => Service['fapolicyd'],
  }
}
