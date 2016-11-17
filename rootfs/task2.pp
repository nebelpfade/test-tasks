class { 'java':
  distribution => 'jre',
}
tomcat::install { '/opt/tomcat':
  source_url => 'https://www.apache.org/dist/tomcat/tomcat-8/v8.5.8/bin/apache-tomcat-8.5.8.tar.gz',
}
tomcat::instance { 'default':
  catalina_home => '/opt/tomcat',
}
tomcat::config::server { 'default':
  catalina_base => '/opt/tomcat',
  address       => '127.0.0.1',
}
tomcat::config::server::connector { 'default':
  catalina_base         => '/opt/tomcat',
  port                  => '8080',
  protocol              => 'HTTP/1.1',
  additional_attributes => {
    'redirectPort' => '8443'
  },
}
class { 'nginx': }
nginx::resource::vhost { 'default':
  listen_port => 8888,
  proxy       => 'http://localhost:8080',
}
