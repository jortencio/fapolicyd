include fapolicyd

fapolicyd::rule_file { 'myapps':
  priority => 80,
  comment  => 'Rules for myapps',
  rules    => [
    {
      decision => 'allow',
      perm     => 'execute',
      subjects => [
        {
          type    => 'exe',
          setting => '/usr/bin/bash',
        },
        {
          type    => 'trust',
          setting => '1',
        },
      ],
      objects  => [
        {
          type    => 'path',
          setting => '/tmp/ls',
        },
        {
          type    => 'ftype',
          setting => 'application/x-executable'
        },
        {
          type    => 'trust',
          setting => '0'
        },
      ]
    }
  ],
}
