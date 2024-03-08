# fapolicyd

A Puppet module that is used to configure `fapolicyd` on Red Hat Enterprise Linux 8 or 9 systems.

For more information about `fapolicyd`, please refer to [Introduction to fapolicyd][1]

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with fapolicyd](#setup)
    * [What fapolicyd affects](#what-fapolicyd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with fapolicyd](#beginning-with-fapolicyd)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This Puppet module can be used to do a basic installation and configuration of `fapolicyd` - A simple application whitelisting daemon for Linux.

## Setup

### What fapolicyd affects

This `fapolicyd` Puppet module currently manages the following configurations:

* Installation of `fapolicyd` package
* Management of the `fapolicyd` service
* Configuration of `/etc/fapolicyd/fapolicyd.conf` file
* Configuration of trusted applications via files under `/etc/fapolicyd/trusted.d/`
* Configuration of rules via files under `/etc/fapolicyd/rules.d/`

### Setup Requirements

In order to use this module, make sure to have the following Puppet modules installed:

* `puppetlabs-stdlib`

### Beginning with fapolicyd

In order to get started with the `fapolicyd` Puppet module to install the `fapolicyd` package and start the `fapolicyd` service with default settings:

```puppet
include fapolicyd
```

## Usage

For additional information regarding the usage of the `fapolicyd` Puppet module, please refer to [REFERENCES][2]

### Whitelist applications using a trust file under `/etc/fapolicyd/trusted.d/`

```puppet
fapolicyd::trust_file { 'myapp':
  trusted_apps => [
    '/tmp/ls',
    '/tmp/cat',
  ],
}
```

### Whitelist applications using a rule file under `/etc/fapolicyd/rules.d/`

```puppet
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
```

## Limitations

This module has only been tested on RedHat 8 and 9 machines

## Development

If you would like to contribute with the development of this module, please feel free to log development changes in the [issues][3] register for this project

[1]: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/security_hardening/assembly_blocking-and-allowing-applications-using-fapolicyd_security-hardening#introduction-to-fapolicyd_assembly_blocking-and-allowing-applications-using-fapolicyd
[2]: https://forge.puppet.com/modules/jortencio/fapolicyd/reference
[3]: https://github.com/jortencio/fapolicyd/issues
