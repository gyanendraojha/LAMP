class lamp {
package {'mysql-client-5.6':

ensure => 'present',

}

package {'mysql-server-5.6':

ensure => 'present',

}
 
service {'mysql':
ensure => 'running',
enable => 'true',
require => Package['mysql-client-5.6'],


}


package {'apache2':
ensure => 'present',
}

service {'apache2':
ensure => 'running',
enable => 'true',
require => Package['apache2'],
}
}

}


node 'task-server.ec2.internal' {
include lamp
include tomcat

}
