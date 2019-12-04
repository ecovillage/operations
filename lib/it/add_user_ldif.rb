require 'securerandom'
require 'base64'

require 'net/ldap'

module Operations
  module IT
    module LDAP
      module AddUser
        def self.pass_hash_ssha passwd
          #salt = SecureRandom.random_bytes(16)
          #pass_value = '{SSHA}' + Base64.encode64(Digest::SHA1.digest(passwd + salt) + salt).chomp!
          salt =  16.times.inject('') {|t| t << rand(16).to_s(16)}
          "{SSHA}" + Base64.encode64("#{Digest::SHA1.digest("#{passwd}#{salt}")}#{salt}").chomp
        end

        def self.ldif user, passwd
          ldif = <<~LDIF
          dn: uid=%{uid},ou=people,dc=siebenlinden,dc=de
          objectClass: posixAccount
          objectClass: inetOrgPerson
          objectClass: organizationalPerson
          objectClass: person
          uid: %{uid}
          cn: %{fullname}
          homeDirectory: /home/%{uid}
          userPassword: %{passwd}
          uidNumber: %{number}
          gidNumber: %{number}
          mail: %{mail}
          sn: %{lastname}
          givenName: %{firstname}
          LDIF
          ldif % {
               uid:       user.uid,
               firstname: user.first_name,
               lastname:  user.last_name,
               fullname:  user.full_name,
               mail:      user.mail,
               number:    user.number,
               passwd:    passwd
              }
        end

        def self.last_uid host=nil, port=nil, user=nil, password=nil, base=nil
          ldap = Net::LDAP.new
          ldap.host = host || ENV['IT_LDAP_HOST']
          ldap.port = port || ENV['IT_LDAP_PORT']
          if (user && password)
            ldap.auth user, password
          else
            ldap.auth ENV['IT_LDAP_AUTH_USER'], ENV['IT_LDAP_AUTH_PASSWORD']
          end
          ldap.bind

          search_base = base || ENV['IT_LDAP_SEARCH_BASE']

          ldap.search(base: search_base).map do |entry|
            entry[:uidnumber]
          end.max
        end
      end
    end
  end
end
