# @summary A class for installing and configuring fapolicyd
#
# This class installs and configures fapolicyd
#
# @param package_ensure
#
#   Set the state of the package
# 
# @param service_ensure
#
#   Set the state of the service
#
# @param service_enable
#
#   Set whether the service is enabled/disabled
#
# @param permissive
#
#
#
# @param nice_val
#
#
#
# @param q_size
#
#
#
# @param uid
#
#
#
# @param gid
#
#
#
# @param do_stat_report
#
#
#
# @param detailed_report
#
#
#
# @param db_max_size
#
#
#
# @param subj_cache_size
#
#
#
# @param obj_cache_size
#
#
#
# @param watch_fs
#
#
#
# @param trust
#
#
#
# @param integrity
#
#
#
# @param syslog_format
#
#
#
# @param rpm_sha256_only
#
#
#
# @param allow_filesystem_mark
#
#
#
# @example
#   include fapolicyd
class fapolicyd (
  Enum['present', 'installed', 'absent'] $package_ensure = 'present',
  Enum['running', 'stopped']             $service_ensure = 'running',
  Boolean                                $service_enable = true,
  Integer[0,1]                           $permissive = 0,
  Integer[0,20]                          $nice_val = 14,
  Integer[1]                             $q_size = 800,
  String[1]                              $uid = 'fapolicyd',
  String[1]                              $gid = 'fapolicyd',
  Integer[0,1]                           $do_stat_report = 1,
  Integer[0,1]                           $detailed_report = 1,
  Integer[1]                             $db_max_size = 50,
  Integer[1]                             $subj_cache_size = 1549,
  Integer[1]                             $obj_cache_size = 8191,
  Array[String[1]]                       $watch_fs = ['ext2','ext3','ext4','tmpfs','xfs','vfat','iso9660','btrfs'],
  Array[String[1]]                       $trust = ['rpmdb','file'],
  Enum['none','size','ima','sha256']     $integrity = 'none',
  Array[String[1]]                       $syslog_format = ['rule','dec','perm','auid','pid','exe',':','path','ftype','trust'],
  Integer[0,1]                           $rpm_sha256_only = 0,
  Integer[0,1]                           $allow_filesystem_mark = 0,
) {
  package { 'fapolicyd':
    ensure => $package_ensure,
  }

  if $package_ensure != 'absent' {
    file { '/etc/fapolicyd/fapolicyd.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'fapolicyd',
      mode    => '0644',
      content => epp('fapolicyd/fapolicyd.conf.epp', {
          permissive            => $permissive,
          nice_val              => $nice_val,
          q_size                => $q_size,
          uid                   => $uid,
          gid                   => $gid,
          do_stat_report        => $do_stat_report,
          detailed_report       => $detailed_report,
          db_max_size           => $db_max_size,
          subj_cache_size       => $subj_cache_size,
          obj_cache_size        => $obj_cache_size,
          watch_fs              => $watch_fs,
          trust                 => $trust,
          integrity             => $integrity,
          syslog_format         => $syslog_format,
          rpm_sha256_only       => $rpm_sha256_only,
          allow_filesystem_mark => $allow_filesystem_mark,
      }),
      require => Package['fapolicyd'],
    }

    service { 'fapolicyd':
      ensure    => $service_ensure,
      enable    => $service_enable,
      subscribe => [
        Package['fapolicyd'],
        File['/etc/fapolicyd/fapolicyd.conf'],
      ],
    }
  }
}
