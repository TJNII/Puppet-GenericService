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
class genericservice::bind( $manage_firewall = true ) {
  # Basic BIND class
  # Installs and enables bind, does nto currently manage its config.

  genericservice::core { 'genericservice_bind':
    service => 'bind',
    systemServiceName => 'named',
  }

  if $manage_firewall == true {
    include firewall-config::base

    firewall { '100 allow TCP DNS':
      state => ['NEW'],
      dport => '53',
      proto => 'tcp',
      action => accept,
    }
  
    firewall { '100 allow UDP DNS':
      state => ['NEW'],
      dport => '53',
      proto => 'udp',
      action => accept,
    }
  }
}
                          
