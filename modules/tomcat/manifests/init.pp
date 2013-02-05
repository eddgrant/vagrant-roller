class tomcat {

  package { "tomcat6" :
    ensure => installed
  }
  
  package { "tomcat6-admin" :
    ensure => installed,
    require => Package['tomcat6'],
  }
  
  service { "tomcat6" :
    enable => true,
    ensure => "running",
    require => Package['tomcat6'],
  }
  
  file { "/etc/tomcat6/tomcat-users.xml":
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => '640',
    require => Package['tomcat6'],
    notify => Service['tomcat6'],
    content => template('tomcat/tomcat-users.xml.erb')
  }
}

define tomcat::deploy-exploded($path) {
 
  class { 'tomcat' : }
  #notice("Establishing http://$hostname:${tomcat::tomcat_port}/$name/")
 
  file { "/var/lib/tomcat6/webapps/${name}":
    ensure => 'directory',
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => '770',
    source => $path,
    recurse => true,
    #notify => Service['tomcat6'],
  }
}

define tomcat::deploy-war($baseDir="/var/lib/tomcat6/webapps",
                          $warFile) {
 
  class { 'tomcat' : }
  #notice("Establishing http://$hostname:${tomcat::tomcat_port}/$name/")
 
  file { "$baseDir" :
    ensure => "directory",
    owner => "tomcat6",
    group => "tomcat6",
    mode => 664,
  }
 
  file { "${baseDir}/${name}.war":
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => '774',
    source => $warFile,
    #notify => Service['tomcat6'],
    require => File["$baseDir"],
  }
}
