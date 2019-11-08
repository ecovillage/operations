#!/usr/bin/env ruby
require "runbook"

#$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require './lib/it/user'
require './lib/it/add_user_ldif'

runbook = Runbook.book "IT/Add LDAP User" do
  description <<~DESC
    This is a runbook that describes how to set up a user in our LDAP
  DESC

  section "Generate LDIF file" do
    step "gather info" do
      ask 'E-Mail-Address of user:', into: 'email'
      ask 'First Name of user:',     into: 'first_name'
      ask 'Last Name of user:',      into: 'last_name'
      ask 'Last UID/GID in LDAP:',    into: 'last_gid'
    end

    step "generate password" do
      path "/home/felix/projects/self/glueckskeks/"
      capture %Q{bundle exec exe/glueckskeks}, into: :passphrase
      ruby_command do
        @passphrase = @passphrase.split("\n")
      end
    end

    step "output ldif file" do
      ruby_command do
        user = Operations::IT::LDAP::User.new first_name: @first_name,
          last_name: @last_name,
          mail: @email,
          number: @last_gid.to_i + 1
        pass_hash = Operations::IT::LDAP::AddUser.pass_hash_ssha @passphrase[1]
        @ldif = Operations::IT::LDAP::AddUser.ldif user, pass_hash
        notice @ldif
      end
    end

    step "save as ldif file" do
    end

    step "import ldif file in ldap" do
    end

    step "print or write down password (with phrase) for user" do
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
