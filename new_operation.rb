#!/usr/bin/env ruby

# Create runbook, make it executable, add it to markdown view generator.

if ARGV.count != 1
  STDERR.puts "need one argument (name/path of runbook)"
  exit 1
end

RUNBOOK_NAME = ARGV[0]

def put_exec cmd
  STDOUT.puts "Execute: #{cmd}"
  `#{cmd}`
end

# Create a new runbook
put_exec "runbook generate runbook #{RUNBOOK_NAME}"

# Make it executable
put_exec "chmod +x #{RUNBOOK_NAME}.rb"

# Add it to documentation markdown view renderer
put_exec "echo #{RUNBOOK_NAME}.rb >> runbooks_to_md.rb"

exec "\$EDITOR #{RUNBOOK_NAME}.rb"

# Exit with grace. As long as there is the exec call above this will never happen, though
exit 0
