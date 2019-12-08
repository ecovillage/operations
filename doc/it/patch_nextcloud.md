# It/Patch Nextcloud

    This is a runbook that patches nextcloud plugins and core functionality

## 1. Gather server info

1. [] Locate the instance

   Connection details (user@host:/path/to/nextcloud) into connection_details

   run:
   ```ruby
   ruby_command do
     @uri = URI("ssh://" + connection_details)
   end
   ```

## 2. Patch up stuff

1. [] True LDAP group autocomplete

   **https://github.com/nextcloud/server/issues/15224**

   run:
   ```ruby
         ruby_command do
           #server @connection_details
   
           sed_cmd = %[sed -i "s/\$result = \$term . '\*';/\$result = '*' . \$term . '\*';/" apps/user_ldap/lib/Access.php]
           notice "URI TEST #{@uri.user}"
           notice "run #{sed_cmd}"
         end
   ```

2. [] Curl download timeout setting for update/app server communication

   **https://github.com/nextcloud/server/issues/14926**

   run:
   ```ruby
   ruby_command do
     sed_cmd = %[sed -i "s/'timeout' => 10,/'timeout' => 90/" lib/private/App/AppStore/Fetcher/Fetcher.php]
     notice "run #{sed_cmd}"
   end
   ```

