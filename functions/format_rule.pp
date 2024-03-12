# @summary A function for formatting a rule to be added to a .rules file
#
# @param rule
#
#  `Fapolicyd::Rule` type rule to be formatted
#
# @return
#
# @api private
#
function fapolicyd::format_rule(Fapolicyd::Rule $rule) >> String {
  $decision = $rule['decision']
  if $rule['perm'] {
    $perm = "perm=${rule['perm']}"
  } else {
    $perm = undef
  }

  $subjects = $rule['subjects'].map | Fapolicyd::Subject $subject | {
    # TODO: Add more validation for each subject type (either here or create individual types)
    case $subject['type'] {
      'all': {
        $subject['type']
      }
      default: {
        "${subject['type']}=${subject['setting']}"
      }
    }
  }

  $objects = $rule['objects'].map | Fapolicyd::Object $object | {
    # TODO: Add more validation for each object type (either here or create individual types)
    case $object['type'] {
      'all': {
        $object['type']
      }
      default: {
        "${object['type']}=${object['setting']}"
      }
    }
  }

  $rule_array = [$decision,$perm,join($subjects,' '),':',join($objects,' ')]
  join($rule_array,' ')
}
