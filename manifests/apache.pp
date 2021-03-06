# Copyright 2013 Tom Noonan II (TJNII)
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
class genericservice::apache(
  $manage_firewall = true,
  $ssl = false,
  $ssl_only = false,
  $enable_ssl_vhost = true,
  ) {
  # Basic Apache2 module
  # Handles services, does not currently handle configs.
    
  case $operatingsystem {
    centos, redhat: {
      $packageName = "httpd"
      $serviceName = "httpd"
    }
    debian: {
      $packageName = apache2
      $serviceName = apache2
    }
  }                                                          
    
  genericservice::core { 'genericservice_apache':
    service           => 'httpd',
    packageName       => $packageName,
    systemServiceName => $serviceName,
  }
  
  if $manage_firewall == true {
    include firewall-config::base

    firewall { '100 allow httpd:80':
      state => ['NEW'],
      dport => '80',
      proto => 'tcp',
      action => accept,
    }
  }

  if $ssl == true {
    case $operatingsystem {
      centos, redhat: {
        package { "mod_ssl":
          ensure => installed,
          notify => Service['httpd'],
        }

        if $ssl_only == true {
          file { "/etc/httpd/conf.d/00_defaulthttp.conf":
            ensure  => file,
            mode    => 644,
            source  => "puppet:///modules/genericservice/apache/00_defaulthttp.conf",
            notify  => Service['httpd'],
            require => Package['mod_ssl'],
          }
        }

      }
      debian: {
        file { '/etc/apache2/mods-enabled/ssl.conf':
          ensure => 'link',
          target => '/etc/apache2/mods-available/ssl.conf',
          notify  => Service['httpd'],
        }
        
        file { '/etc/apache2/mods-enabled/ssl.load':
          ensure => 'link',
          target => '/etc/apache2/mods-available/ssl.load',
          notify  => Service['httpd'],
        }

        if $enable_ssl_vhost == true {
          file { '/etc/apache2/sites-enabled/default-ssl':
            ensure => 'link',
            target => '/etc/apache2/sites-available/default-ssl',
            notify  => Service['httpd'],
          }
        }
      }

      default: {}
    }

    if $manage_firewall == true {
      include firewall-config::base
      
      firewall { '100 allow httpd:443':
        state => ['NEW'],
        dport => '443',
        proto => 'tcp',
        action => accept,
      }
    }
  }    
}
        
