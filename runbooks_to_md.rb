#!/usr/bin/env ruby

require 'runbook'

# Generate markdown views of runbooks listed at end of this file.
# The .md files are stored in (doc/)[doc/] .

# Eventually, this could become a Rake task.

# Books are defined at end of this file (to allow for easy automated manipulation).
books = DATA.readlines.map{|l| l.strip}

index_file_data = "# List of runbooks\n"

# Runbooks register themselves to Runbook.books when they are defined
# (Or alternatively `runbook = eval(File.read("my_runbook.rb"))`)
books.each do |book|
  filename = File.join("doc", book.sub('.rb', '.md'))

  STDOUT.puts "processing #{book} -> #{filename}"

  index_file_data += "  * [#{book}](#{filename[4..-1]})\n"

  load book
  md = Runbook::Viewer.new(Runbook.books.last).generate(view: :markdown)

  FileUtils.mkdir_p(File.dirname filename)
  File.write(filename, md)
end

File.write('doc/index.md', index_file_data)

# We are doing this trick such that new runbooks can easily be added with
# echo 'runbook_name.rb' >> runbooks_to_md.rb .
# Whatever follows END will be available as DATA I/O (see above).

__END__
it/add_ldap_user.rb
it/remove_guest_users_groups.rb
it/update_child_theme.rb
