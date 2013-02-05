#MYSQL properties
$mysql_root_password="adminadmin"

#Roller properties
$roller_db_name='rollerdb'
$roller_db_user='roller'
$roller_db_password='rollerpass'
$roller_base_data_dir='/Data'
$roller_context_path='roller'
  
#SMTP server properties
$smtp_host="smtp.gmail.com"
$smtp_port="465"
$smtp_user="blog@mydomain.com"
$smtp_password="ThisIsNotMyRealPassword"
$smtp_sender="blog@mydomain.com"

#TODO: Fix apt-get update so it happens prior to package installation only
# as per http://johnleach.co.uk/words/771/puppet-dependencies-and-run-stages
exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

Exec["apt-update"] -> Package <| |>
  
class { 'roller' : 
  roller_version => '4.0.1',
  roller_db_name => $roller_db_name,
  roller_db_user => $roller_db_user,
  roller_db_password => $roller_db_password,
  roller_base_data_dir => $roller_base_data_dir,
  roller_context_path => $roller_context_path,
  smtp_host => $smtp_host,
  smtp_port => $smtp_port,
  smtp_user => $smtp_user,
  smtp_password => $smtp_password,
  smtp_sender => $smtp_sender,
}
