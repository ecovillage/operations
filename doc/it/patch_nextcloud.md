# It/Patch Nextcloud

    This is a runbook that patches nextcloud plugins and core functionality

## 1. Gather server info

1. [] Locate the instance

   Connection details (user@host:/path/to/nextcloud) into connection_details

## 2. Patch up stuff

1. [] True LDAP group autocomplete

   **https://github.com/nextcloud/server/issues/15224**

   run:
   ```ruby
   ruby_command do
     notice "run #{sed_cmd}"
   end
   ```

2. [] Curl download timeout setting for update/app server communication

   **https://github.com/nextcloud/server/issues/14926**

   run:
   ```ruby
   ruby_command do
     notice "run #{sed_cmd}"
   end
   ```

