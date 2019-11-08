#!/usr/bin/env ruby
require "runbook"

#$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require './lib/it/user'
require './lib/it/add_user_ldif'

runbook = Runbook.book "IT/Add LDAP User" do
  description <<~DESC
    This is a runbook that describes how to set up a new user in our LDAP
  DESC

  section "Generate LDIF file" do
    step "Gather new user information" do
      ask 'E-Mail-Address of user:', into: 'email'
      ask 'First Name of user:',     into: 'first_name'
      ask 'Last Name of user:',      into: 'last_name'
      ask 'Last UID/GID in LDAP:',    into: 'last_gid'
    end

    step "Generate password" do
      path "/home/felix/projects/self/glueckskeks/"
      capture %Q{bundle exec exe/glueckskeks}, into: :passphrase
      ruby_command do
        @passphrase = @passphrase.split("\n")
      end
    end

    step "Generate ldif data" do
      ruby_command do
        @user = Operations::IT::LDAP::User.new first_name: @first_name,
          last_name: @last_name,
          mail: @email,
          number: @last_gid.to_i + 1
        pass_hash = Operations::IT::LDAP::AddUser.pass_hash_ssha @passphrase[1]
        @ldif = Operations::IT::LDAP::AddUser.ldif @user, pass_hash
        notice @ldif
      end
    end

    step "Save as ldif file" do
      ruby_command do
        filename = "/tmp/#{@user.uid}.ldif"
        File.write(filename, @ldif)
        notice "Wrote ldif to #{filename}"
      end
    end

    step "Import ldif file in LDAP" do
    end

    step "Reflect on Group memberships" do
    end

    step "Print or write down password (with phrase) for new user" do
    end

    step "Deliver information to new user" do
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
