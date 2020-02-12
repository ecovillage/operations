# Operations

Playing around with [runbooks](https://github.com/braintree/runbook) in the context of tasks that have to be done now in then in our infrastructure.

Runbooks idea is gradual automation, you start with no-op scripts that just define the necessary steps and then you start slowly filling the gaps and automate parts of the process.

This repository also comes with a script to generate the markdown rendering of the processes (runbooks).

## Usage

run `bundle` to install the `runbook` and other dependencies (you need to have ruby version >= 2.3 installed for all that).

### Creating new runbooks

To cover all steps, use `./new_operation.rb <NAME_OF_RUNBOOK>`, where `NAME_OF_RUNBOOK` is e.g. `it/do_the_task`.

This will create the runbook `it/do_the_task.rb`, make it executable and add it to the list of runbooks for which markdown doc generation is done when `./runbooks_to_md.rb` is executed.

The script will take care of

    runbook generate runbook it/do_the_task
    chmod +x it/do_the_task.rb
    echo it/do_the_task.rb >> runbooks_to_md.rb
    $EDITOR it/do_the_task.rb
.

#### Where does my custom code and asset go?

TBD. Currently look for `lib/<pathtorunbook>`.  Put tests into `test/<pathtorunbook>`.

### Running runbooks

The runbooks are executables.  Run them from the base-directory (e.g. `it/add_ldap_user.rb`).

Or `runbook exec <path_to_runbook>`, or (without input) `runbook exec --auto <path_to_runbook>`.

#### Runbook configuration

`it/add_ldap_user` does load the file `ldap.env` as environment variables, if present and the gem `dotenv` is installed.

## Runbooks contained

  * [it/add_ldap_user.rb](it/add_ldap_user.rb): Add a new LDAP user to the directory.
  * ...

See [doc/index](doc/index.md) (or [doc/](doc/) directory) for a list and details about runbooks.

## Updating runbooks

After editing the code, update the documentation / markdown view with

    ./runbooks_to_md.rb

## Creating doc/*md from runbooks

Execute `runbooks_to_md.rb` to populate `doc/` folder (TODO: make this a rake task? Or a runbook itself? ...).
To incorporate new runbooks, edit `runbooks_to_md.rb` and include the file.  Note that this will be done for you if you add new runbooks via the `new_operation.md <nameoftask>` script given above.

### Browsing documentation / runbooks

You can use [madness](https://github.com/DannyBen/madness) (`gem install madness`) to fire up a webserver that displays the markdown files.

## Tests

`rake` or `rake test`, done with MiniTest.

## Contributing

Yay! Happy! Drop me a line.

## License

Copyright 2019 Felix Wolfsteller, released under the GPLv3+ License (contained as file `LICENSE` in this repository).
