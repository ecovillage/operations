require 'asciify'

module Operations
  module IT
    module LDAP
      User = Struct.new(:first_name, :last_name, :mail, :number, :pass_hash, keyword_init: true) do
        def uid
          map = Asciify::Mapping.new(:default)
          ("%s.%s" % [first_name.asciify(map), last_name.asciify(map)]).downcase
        end

        def full_name #cn
          "%s %s" % [first_name, last_name]
        end
      end
    end
  end
end

