#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "It/Patch Nextcloud" do
  description <<-DESC
    This is a runbook that patches nextcloud plugins and core functionality
  DESC

  section "Gather server info" do
    step "Locate the instance" do
      ask "Connection details (user@host:/path/to/nextcloud)", into: :connection_details
    end
  end

  section "Patch up stuff" do
    step "True LDAP group autocomplete" do
      notice "https://github.com/nextcloud/server/issues/15224"
      ruby_command do
        sed_cmd = %[sed -i "s/\$result = \$term . '\*';/\$result = '*' . \$term . '\*';/" apps/user_ldap/lib/Access.php]
        notice "run #{sed_cmd}"
      end
    end

    step "Curl download timeout setting for update/app server communication" do
      notice "https://github.com/nextcloud/server/issues/14926"
      ruby_command do
        sed_cmd = %[sed -i "s/'timeout' => 10,/'timeout' => 90/" lib/private/App/AppStore/Fetcher/Fetcher.php]
        notice "run #{sed_cmd}"
      end
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
