type Fapolicyd::Rule = Struct[
  'decision' => Enum['allow', 'deny', 'allow_audit', 'deny_audit', 'allow_syslog', 'deny_syslog', 'allow_log', 'deny_log'],
  'perm' => Optional[Enum['open', 'execute', 'any']],
  'subjects' => Array[Fapolicyd::Subject,1],
  'objects' => Array[Fapolicyd::Object],
]
