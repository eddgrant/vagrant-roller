#TODO: Document the fact that the $::mysql_root_password variable must be set as it is used here.
class mysql() {

  #$mysql_root_password = "$root_password"
  
  package { 'mysql-server' : 
    ensure => 'installed'
  }
  
  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p\"$::mysql_root_password\" status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password \"$::mysql_root_password\"",
    require => Service["mysql"],
  }
}

#TODO: Give example usage with installation of MySQL (and setting of root password) as a first step.
define mysql::db($user, $password) {

  class { 'mysql' : }

  exec { "create-${name}-db":
    unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
    command => "/usr/bin/mysql -uroot -p$::mysql_root_password -e \"create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
    require => Class["mysql"],
  }
}
