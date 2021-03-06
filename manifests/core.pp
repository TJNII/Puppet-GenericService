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
define genericservice::core(
  $service,
  $packageName = undef,
  $systemServiceName = undef,
  ) {
    # Generic service handler
    # Handles service package and init, does not handle configs.
    # Does not handle the firewall.

    if $packageName == undef {
      $intPackageName = $service
    } else {
      $intPackageName = $packageName
    }

    if $systemServiceName == undef {
      $intServiceName = $service
    } else {
      $intServiceName = $systemServiceName
    }
    
    package { "$service":
      name => "$intPackageName",
      ensure => installed,
    }
    
    service { "$service":
      name      => $intServiceName,
      ensure    => running,
      enable    => true,
    }
  }
        
