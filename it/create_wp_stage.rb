#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "It/Create WP Stage" do
  description <<-DESC
    This is a runbook to create a staging copy of a Wordpress installation.
  DESC

  section "Gather details" do
    step "Define source and target host and domain" do
    end
    step "Define source and target db" do
    end
  end

  section "Copy data" do
    step "Copy files" do
    end
    step "Dump DB" do
    end
    step "Import/restore DB" do
    end
  end

  section "Configure infrastructure" do
    step "Edit DB and/or/incl. WP conf to reflect host change" do
    end
    step "Modify user accounts/passwords" do
    end
    step "Modify admin backend color" do
    end
    step "Configure webserver" do
    end
    step "Add host entry" do
    end
    step "Restart web server" do
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
