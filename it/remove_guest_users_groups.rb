#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "It/Remove Guest Users Groups" do
  description <<~DESC
    This is a runbook to remove the guest login users and groups created by guest logins on Ubuntu < 18.04 (except guest-prefs).
  DESC

  section "Remove Users and Groups" do
    step "Remove users except guest-prefs" do
      command "rgrep guest- /etc/group  | grep -v guest-prefs | cut -f 1 -d ':' | sudo xargs -L 1 deluser "
    end

    step "Remove rogue groups except guest-prefs" do
      command "rgrep guest- /etc/passwd | grep -v guest-prefs | cut -f 1 -d ':' | sudo xargs -L 1 deluser --group "
    end
  end

  section "Persist the solution" do
    step "Install as @reboot cronjob, service or init script" do
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
