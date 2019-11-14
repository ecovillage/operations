# List of runbooks
  * [it/add_ldap_user.rb](it/add_ldap_user.md)
    > This is a runbook that describes how to set up a new user in our LDAP
  * [it/create_wp_stage.rb](it/create_wp_stage.md)
    > This is a runbook to create a staging copy of a Wordpress installation.
  * [it/patch_nextcloud.rb](it/patch_nextcloud.md)
    >     This is a runbook that patches nextcloud plugins and core functionality
  * [it/remove_guest_users_groups.rb](it/remove_guest_users_groups.md)
    > This is a runbook to remove the guest login users and groups created by guest logins on Ubuntu < 18.04 (except guest-prefs).
  * [it/update_child_theme.rb](it/update_child_theme.md)
    > This is a runbook that defines the steps necessary to update the Wordpress Hueman 7L child theme to match Hueman upstream.
    > Child Theme is found at: https://github.com/ecovillage/hueman-7l-child
    > Hueman Theme Upstream is found at https://github.com/presscustomizr/hueman
    > You might need to adjust the path definitions in this file in order to work with it.
    > git rebase would come to the rescue, but for that, it seems to be too late and also because we are dealing with diffs (child theme) its yet unclear how this would work smoothly.
