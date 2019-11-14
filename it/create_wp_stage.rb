#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "It/Create WP Stage" do
  description <<~DESC
    This is a runbook to create a staging copy of a Wordpress installation.
  DESC

  section "Gather details" do
    step "Define source host and domain" do
      ask "Source ('production') connection (user@host)", into: :ssh_source
      ask "Source ('production') location (/path/to/wp/)", into: :source_location
    end

    step "Define target host and domain" do
      ask "Target ('stage') location (user@host:/path/to/wp/)?", into: :target_ssh
    end

    step "Download source ('production') tarball" do
      assert '[ ! -f source.tgz ]', attempts: 1
      ruby_command do
        # (https://github.com/braintree/runbook/issues/21 and https://github.com/braintree/runbook/issues/22)
        capture %Q{ssh #{@ssh_source} 'cd && tar -cf - #{@source_location} | gzip -9' > source.tgz}, into: :ssh_download_msg
      end
    end

    step "Define source db" do
      # tar --extract --file=source.tgz wp-config.php
      ask "DB Host of production DB", into: :source_db_host
      ask "DB User of production DB", into: :source_db_user
      ask "DB Pass of production DB", into: :source_db_pass
      ask "DB Name of production DB", into: :source_db_name
      # capture tar --extract --file=source.tgz wp-config.php
      # and ruby grep in it
    end

    step "Define target db" do
      # tar --extract --file=source.tgz wp-config.php
      ask "DB Host", into: :target_db_host
      ask "DB User", into: :target_db_user
      ask "DB Pass", into: :target_db_pass
      ask "DB Name", into: :target_db_name
      # capture tar --extract --file=source.tgz wp-config.php
      # and ruby grep in it
    end

  end

  section "Copy data" do
    step "Copy files" do
      # Let confirm source and target definitions to not wreck havoc
    end

    step "Dump DB" do
      ruby_command do
        # (https://github.com/braintree/runbook/issues/21 and https://github.com/braintree/runbook/issues/22)
        capture %Q{ssh #{@ssh_source} 'mysqldump --host=#{@source_db_host} --user=#{@source_db_user} --password=#{@source_db_pass} --#{@source_db_name} | gzip -9' > sourcedb.gz}, into: :ssh_download_msg
      end
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
