#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "It/Up Collabora" do
  description <<~DESC
   Stop COLLABORAOFFICE docker container, remove it, update it, restart it
  DESC

  section "SECTION" do
    step "stop the COLLABORAOFFICE container" do
      command "docker stop COLLABORAOFFICE"
    end

    step "remove the COLLABORAOFFICE container" do
      command "docker rm COLLABORAOFFICE"
    end

    step "update image" do
      command "docker pull collabora/code"
    end

    step "restart the container"
      command "docker run -t -d -p 127.0.0.1:9980:9980 -e 'domain=the\\.moandin\\.net' -e \"username=flusername\" -e \"password=iaosudhag2ü\" --name=COLLABORAOFFICE --restart always --cap-add MKNOD collabora/code"
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
