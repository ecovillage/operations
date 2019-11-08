#!/usr/bin/env ruby

require 'runbook'

books = ["it/add_ldap_user.rb"]

# Runbooks register themselves to Runbook.books when they are defined
# (Or alternatively `runbook = eval(File.read("my_runbook.rb"))`)
books.each do |book|
  filename = File.join("doc", book.sub('.rb', '.md'))

  md = Runbook::Viewer.new(eval(File.read book)).generate(view: :markdown)

  FileUtils.mkdir_p(File.dirname filename)
  File.write(filename, md)
end
