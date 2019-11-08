# Operations

Testing [runbooks](https://github.com/braintree/runbook).

## Usage

run `bundle` to install the `runbook` and other dependencies (you need to have ruby installed for all that).

### Creating new runbooks

`runbook generate ?`

### Running runbooks

The runbooks are executables.  Run them from the base-directory (e.g. `it/add_ldap_user.rb`).

## Runbooks contained

  * [it/add_ldap_user.rb](it/add_ldap_user.rb): Add a new LDAP user to the directory.

## Updating runbooks

## Creating doc/*md from runbooks

Execute `runbooks_to_md.rb` to populate `doc/` folder (TODO: make this a rake task).
To incorporate new runbooks, edit `runbooks_to_md.rb` and include the file.

## Tests

`rake` or `rake test`, done with MiniTest.

## Contributing

Yay! Happy! Drop me a line.

## License

Copyright 2019 Felix Wolfsteller, released under the GPLv3+ License (contained as file `LICENSE` in this repository).
