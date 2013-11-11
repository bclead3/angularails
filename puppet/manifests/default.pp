class {'locales':
  autoupgrade => true,
  locales     => 'en_US.UTF-8 UTF-8',
}

class postgres {
  class { 'postgresql':
    require => Class['locales'],
    charset => 'unicode',
    locale  => 'en_US.UTF-8',
  }->
  class { 'postgresql::server':
    require => Class['postgresql'],
    config_hash => {
      'ip_mask_deny_postgres_user' => '0.0.0.0/32',
      'ip_mask_allow_all_users'    => '0.0.0.0/0',
      'listen_addresses'           => '*',
      'postgres_password'          => 'postgres',
    },
  }
  class { 'postgresql::devel': }
  # workaround for http://projects.puppetlabs.com/issues/4695
  # when PostgreSQL is installed with SQL_ASCII encoding instead of UTF8
  exec { 'utf8 postgres':
    command => 'pg_dropcluster --stop 9.1 main ; pg_createcluster --start --locale en_US.UTF-8 9.1 main',
    unless  => 'sudo -u postgres psql -t -c "\l" | grep template1 | grep -q UTF',
    require => Class['postgresql::server'],
    path    => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
  }
}
include postgres

class {'display':}