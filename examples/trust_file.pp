include fapolicyd

fapolicyd::trust_file { 'myapp':
  trusted_apps => [
    '/tmp/ls',
    '/tmp/cats',
  ],
}
