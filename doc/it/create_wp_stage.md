# It/Create WP Stage

This is a runbook to create a staging copy of a Wordpress installation.

## 1. Gather details

1. [] Define source host and domain

   Source ('production') connection (user@host) into ssh_source

   Source ('production') location (/path/to/wp/) into source_location

2. [] Define target host and domain

   Target ('stage') location (user@host:/path/to/wp/)? into target_ssh

3. [] Download source ('production') tarball

   run: `[ ! -f source.tgz ]` every 1 seconds until it returns 0

   after 1 attempts, abort...

   and exit

   run:
   ```ruby
   ruby_command do
     # (https://github.com/braintree/runbook/issues/21 and https://github.com/braintree/runbook/issues/22)
     capture %Q{ssh #{@ssh_source} 'cd && tar -cf - #{@source_location} | gzip -9' > source.tgz}, into: :ssh_download_msg
   end
   ```

4. [] Define source db

   DB Host of production DB into source_db_host

   DB User of production DB into source_db_user

   DB Pass of production DB into source_db_pass

   DB Name of production DB into source_db_name

5. [] Define target db

   DB Host into target_db_host

   DB User into target_db_user

   DB Pass into target_db_pass

   DB Name into target_db_name

## 2. Copy data

1. [] Copy files

2. [] Dump DB

   run:
   ```ruby
   ruby_command do
     # (https://github.com/braintree/runbook/issues/21 and https://github.com/braintree/runbook/issues/22)
     capture %Q{ssh #{@ssh_source} 'mysqldump --host=#{@source_db_host} --user=#{@source_db_user} --password=#{@source_db_pass} --#{@source_db_name} | gzip -9' > sourcedb.gz}, into: :ssh_download_msg
   end
   ```

3. [] Import/restore DB

## 3. Configure infrastructure

1. [] Edit DB and/or/incl. WP conf to reflect host change

2. [] Modify user accounts/passwords

3. [] Modify admin backend color

4. [] Configure webserver

5. [] Add host entry

6. [] Restart web server

