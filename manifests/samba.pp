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
class genericservice::samba( $manage_firewall = true ) {
  # Basic Samba module
  # Handles services, does not currently handle configs.

  genericservice::core {'genericservice_samba':
    service           => 'samba',
    systemServiceName => 'smb',
  }
  
  if $manage_firewall == true {
    include firewall-config::base

    firewall { '100 allow samba:445':
      state => ['NEW'],
      dport => '445',
      proto => 'tcp',
      action => accept,
    }
  }
}
        
