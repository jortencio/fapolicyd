# @summary A type for managing fapolicyd rules files
#
# A type for managing fapolicyd rules files under `/etc/fapolicyd/rules.d/`
#
# @param priority
#
#  Priority of the rules in the rule file
#
# @param comment
#
#  A comment to place into the rules file for describing the rules
#
# @param rules
#
#  An array of rules to add to the rules file
#
# @example
#   fapolicyd::rule_file { 'myapps':
#     priority => 80,
#     comment  => 'Rules for myapps',
#     rules    => [
#       {
#         decision => 'allow',
#         perm     => 'execute',
#          subjects => [
#           {
#             type    => 'exe',
#             setting => '/usr/bin/bash',
#           },
#           {
#             type    => 'trust',
#             setting => '1',
#           },
#         ],
#         objects  => [
#           {
#             type    => 'path',
#             setting => '/tmp/ls',
#           },
#           {
#             type    => 'ftype',
#             setting => 'application/x-executable'
#           },
#           {
#             type    => 'trust',
#             setting => '0'
#           },
#         ]
#       }
#     ],
#   }
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
