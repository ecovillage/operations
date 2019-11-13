#!/usr/bin/env ruby
require "runbook"

runbook = Runbook.book "It/Update Child Theme" do
  description <<~DESC
    This is a runbook that defines the steps necessary to update the Wordpress Hueman 7L child theme to match Hueman upstream.
    Child Theme is found at: https://github.com/ecovillage/hueman-7l-child
    Hueman Theme Upstream is found at https://github.com/presscustomizr/hueman
    You might need to adjust the path definitions in this file in order to work with it.
  DESC

  local_child_path    = "~/projects/7l/fk/hueman-7l-child/"
  local_upstream_path = "~/projects/7l/fk/hueman-repo/hueman/"

  section "Find out branches and versions" do
    step "Find out which version the current child is based off." do
      path local_child_path
      capture %Q{cat HUEMAN_BASE_VERSION}, into: :base_version
    end

    step "Find version of upstream Hueman theme." do
      path local_upstream_path
      capture %Q{git tag --list 'v*' --sort="version:refname" | tail -n 1}, into: :upstream_version
    end

    step "Smile if nothing has to be done" do
      ruby_command do
        if @base_version == @upstream_version
          notice "Nothing to do, exit now!"
        else
          notice "Child is based on: #{@base_version}"
          notice "Upstream hueman is: #{@upstream_version}"
        end
      end
    end
  end

  section "'Rebase' changes of upstream into child theme" do
    step "Find base files of files in child" do
    end

    step "Find upstream changes" do
    end

    step "Integrate upstream changes" do
    end

    step "Update child themes HUEMAN_BASE_VERSION" do
    end

    step "Tag and push a new child theme version" do
    end

    step "Update parent theme in wordpress" do
    end

    step "Update child theme in wordpress" do
    end
  end
end

if __FILE__ == $0
  Runbook::Runner.new(runbook).run
else
  runbook
end
