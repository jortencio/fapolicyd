# @summary A class for installing and configuring fapolicyd
#
# This class installs and configures fapolicyd
#
# @param package_ensure
#
#  Set the state of the package
# 
# @param service_ensure
#
#  Set the state of the service
#
# @param service_enable
#
#  Set whether the service is enabled/disabled
#
# @param permissive
#
#  Set to 0 to send policy decision to the kernel for enforcement.  Set to 1 to always allow access even if a policy would block it.
#
# @param nice_val
#
#  Set a process niceness value scheduler boost
#
# @param q_size
#
#  Set the queue size for the internal queue that fapolicyd will use.
#
# @param uid
#
#  Set the uid or name of the user account under which fapolicy should switch to during startup
#
# @param gid
#
#  Set the gid or name of the group under which fapolicy should switch to during startup
#
# @param do_stat_report
#
#  Set whether fapolicy do should (1) or should not (0) create a usage statistics policy on shutdown
#
# @param detailed_report
#
#  Set whether fapolicyd should(1) or should not(0) add subject and object information to the usage statistics report
#
# @param db_max_size
#
#  Set how many megabytes to allow the trust database to grow to
#
# @param subj_cache_size
#
#  Set how many entries the subject cache holds
#
# @param obj_cache_size
#
#  Set how  many entries the object cache holds
#
# @param watch_fs
#
#  Set a list of file systems that should be watched for access permission
#
# @param trust
#
#  Set list  of trust back-ends
#
# @param integrity
#
#  Set the integrity strategy that should be used
#
# @param syslog_format
#
#  Set the format of the output from the access decision 
#
# @param rpm_sha256_only
#
#  Set option (0 or 1) for whether the daemon should be forced to only work with SHA256 hashes
#
# @param allow_filesystem_mark
#
#  Set option (0 or 1) for whether to allow fapolicyd to monitor file access events on the underlying file system when they are bind 
#  mounted or are overlayed
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
  Array[Enum['rpmdb','file'],1,2]        $trust = ['rpmdb','file'],
  Enum['none','size','ima','sha256']     $integrity = 'none',
  String[1]                              $syslog_format = 'rule,dec,perm,auid,pid,exe,:,path,ftype,trust',
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
