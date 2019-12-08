# IT/Add LDAP User

This is a runbook to set up a new user in our LDAP

## 1. Generate LDIF file

1. [] Gather new user information

   E-Mail-Address of user: into email

   First Name of user: into first_name

   Last Name of user: into last_name

   Last UID in LDAP: into last_uid

2. [] Generate password

   within: /home/felix/projects/self/glueckskeks/

   capture: `bundle exec exe/glueckskeks` into passphrase

   run:
   ```ruby
   ruby_command do
     @passphrase = @passphrase.split("\n")
   end
   ```

3. [] Generate ldif data

   run:
   ```ruby
   ruby_command do
     @user = Operations::IT::LDAP::User.new first_name: @first_name,
       last_name: @last_name,
       mail: @email,
       number: @last_uid.to_i + 1
     pass_hash = Operations::IT::LDAP::AddUser.pass_hash_ssha @passphrase[1]
     @ldif = Operations::IT::LDAP::AddUser.ldif @user, pass_hash
     notice @ldif
   end
   ```

4. [] Save as ldif file

   run:
   ```ruby
   ruby_command do
     filename = "/tmp/#{@user.uid}.ldif"
     File.write(filename, @ldif)
     notice "Wrote ldif to #{filename}"
   end
   ```

5. [] Import ldif file in LDAP

6. [] Reflect on Group memberships

7. [] Print or write down password (with phrase) for new user

8. [] Deliver information to new user

