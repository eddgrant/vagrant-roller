class roller($roller_version = '4.0.1',
             $roller_db_host = 'localhost',
             $roller_db_port = '3306',
             $roller_db_name = 'rollerdb',
             $roller_db_user = 'roller',
             $roller_db_password = 'rollerpass',
             $roller_base_data_dir = '/Data',
             $roller_context_path = 'roller',
             $smtp_host,
             $smtp_port,
             $smtp_user,
             $smtp_password,
             $smtp_sender) {

  ######################################################
  ### Create an empty MySQL Database for Roller.
  ######################################################
    
  mysql::db { "$roller_db_name" :
    user => "$roller_db_user",
    password => "$roller_db_password",
  }
  
  ######################################################
  ### Create jars and property files required by Roller.
  ######################################################
  
  file { ["$roller_base_data_dir",
          "$roller_base_data_dir/roller",
          "$roller_base_data_dir/roller/config",
          "$roller_base_data_dir/roller/tomcat-lib",
          "$roller_base_data_dir/roller/planet_cache",
          "$roller_base_data_dir/roller/search-index",
          "$roller_base_data_dir/roller/mediafiles"] :
    owner => 'tomcat6',
    group => 'tomcat6',
    ensure => 'directory',
    recurse => true,
    require => [Package["tomcat6"], Mysql::Db["$roller_db_name"]],
  }
  
  file { "$roller_base_data_dir/roller/themes" :
   ensure => 'directory',
   owner => 'tomcat6',
   group => 'tomcat6',
   mode => '774',
   source => 'puppet:///modules/roller/themes',
   recurse => true,
   require => File["$roller_base_data_dir/roller"],
  }
  
  #Roller config files.
  file { "$roller_base_data_dir/roller/config/planet-custom.properties" :
    ensure => 'present',
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => '740',
    content => template("roller/planet-custom.properties.erb"),
    require => File["$roller_base_data_dir/roller/config"],
  }
  
  file { "$roller_base_data_dir/roller/config/roller-custom.properties" :
    ensure => 'present',
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => '740',
    content => template("roller/roller-$roller_version-custom.properties.erb"),
    require => File["$roller_base_data_dir/roller/config"],
  }
  
  #Tomcat lib jars.
  file { "$roller_base_data_dir/roller/tomcat-lib/mysql-connector-java.jar" :
    ensure => 'present',
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => 740,
    source => 'puppet:///modules/roller/tomcat-lib/mysql-connector-java.jar',
    require => File["$roller_base_data_dir/roller/tomcat-lib"],
  }
  
  file { "$roller_base_data_dir/roller/tomcat-lib/activation.jar" :
    ensure => 'present',
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => 740,
    source => 'puppet:///modules/roller/tomcat-lib/activation.jar',
    require => File["$roller_base_data_dir/roller/tomcat-lib"],
  }
  
  file { "$roller_base_data_dir/roller/tomcat-lib/mail.jar" :
    ensure => 'present',
    owner => 'tomcat6',
    group => 'tomcat6',
    mode => 740,
    source => 'puppet:///modules/roller/tomcat-lib/mail.jar',
    require => File["$roller_base_data_dir/roller/tomcat-lib"],
  }
  
  ######################################################
  ### Create Symlinks to jars and property files
  ### (puts them on the Tomcat classpath)
  ######################################################
  
  file { '/usr/share/tomcat6/lib/planet-custom.properties' :
    ensure => 'link',
    target => "$roller_base_data_dir/roller/config/planet-custom.properties",
    require => File["$roller_base_data_dir/roller/config/planet-custom.properties"],
  }
  
  file { '/usr/share/tomcat6/lib/roller-custom.properties' :
    ensure => 'link',
    target => "$roller_base_data_dir/roller/config/roller-custom.properties",
    require => File["$roller_base_data_dir/roller/config/roller-custom.properties"],
  }
  
  file { '/usr/share/tomcat6/lib/mysql-connector-java.jar' :
    ensure => 'link',
    target => "$roller_base_data_dir/roller/tomcat-lib/mysql-connector-java.jar",
    require => File["$roller_base_data_dir/roller/tomcat-lib/mysql-connector-java.jar"],
  }
  
  file { '/usr/share/tomcat6/lib/activation.jar' :
    ensure => 'link',
    target => "$roller_base_data_dir/roller/tomcat-lib/activation.jar",
    require => File["$roller_base_data_dir/roller/tomcat-lib/activation.jar"],
  }
  
  file { '/usr/share/tomcat6/lib/mail.jar' :
    ensure => 'link',
    target => "$roller_base_data_dir/roller/tomcat-lib/mail.jar",
    require => File["$roller_base_data_dir/roller/tomcat-lib/mail.jar"],
  }
  
  ######################################################
  ### Deploy a Tomcat context.xml file as roller.xml
  ### to set up the deployment context path.
  ######################################################
  
  file { "/var/lib/tomcat6/conf/Catalina/localhost/$roller_context_path.xml" :
    ensure => 'present',
    owner => 'tomcat6',
    group => 'tomcat6',
    content => template("roller/context.xml.erb"),
    require => Package["tomcat6"],
  }

  #Deploy the roller webapp
  tomcat::deploy-war { "$roller_context_path":
    baseDir => "/var/lib/tomcat6/non-appBase-webapps",
    warFile => "puppet:///modules/roller/roller-app-$roller_version.war",
    require => [File["$roller_base_data_dir/roller/themes"],
                File["/usr/share/tomcat6/lib/planet-custom.properties"],
                File["/usr/share/tomcat6/lib/roller-custom.properties"],
                File["/usr/share/tomcat6/lib/mysql-connector-java.jar"],
                File["/usr/share/tomcat6/lib/activation.jar"],
                File["/usr/share/tomcat6/lib/mail.jar"], 
                File["/var/lib/tomcat6/conf/Catalina/localhost/$roller_context_path.xml"]],
  }
  
}
