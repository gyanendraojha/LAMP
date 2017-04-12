class tomcat (
  $catalina_home       = $::tomcat::params::catalina_home,
  $user                = $::tomcat::params::user,
  $group               = $::tomcat::params::group,
  $install_from_source = true,
  $purge_connectors    = false,
  $purge_realms        = false,
  $manage_user         = true,
  $manage_group        = true,
  $manage_home         = true,
  $manage_base         = true,
) inherits ::tomcat::params {
  validate_bool($install_from_source)
  validate_bool($purge_connectors)
  validate_bool($purge_realms)
  validate_bool($manage_user)
  validate_bool($manage_group)
  validate_bool($manage_home)
  validate_bool($manage_base)
#class { 'java': }
tomcat::install { '/opt/tomcat7':
  source_url => 'https://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz',
}
#tomcat::instance { 'default':
 #catalina_home => '/opt/tomcat',
#}
tomcat::instance { 'tomcat7-first':
#tomcat::instance { 'default':
 catalina_home => '/opt/tomcat7',
catalina_base => '/opt/tomcat7/first',
}

tomcat::instance { 'tomcat7-second':
 catalina_home => '/opt/tomcat7',
  catalina_base => '/opt/tomcat7/second',
}

tomcat::config::server { 'tomcat7-second':
 catalina_base => '/opt/tomcat7/second',
  port          => '8006',
}
tomcat::config::server::connector { 'tomcat7-second-http':
 catalina_base         => '/opt/tomcat7/second',
  port                  => '8081',
  protocol              => 'HTTP/1.1',
  additional_attributes => {
   'redirectPort' => '8443'
  },
}




 case $::osfamily {
    'windows','Solaris','Darwin': {
      fail("Unsupported osfamily: ${::osfamily}")
    }
    default: { }
  }
}
