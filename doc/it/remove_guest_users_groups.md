# It/Remove Guest Users Groups

This is a runbook to remove the guest login users and groups created by guest logins on Ubuntu < 18.04 (except guest-prefs).

## 1. Remove Users and Groups

1. [] Remove users except guest-prefs

   run: `rgrep guest- /etc/group  | grep -v guest-prefs | cut -f 1 -d ':' | sudo xargs -L 1 deluser `

2. [] Remove rogue groups except guest-prefs

   run: `rgrep guest- /etc/passwd | grep -v guest-prefs | cut -f 1 -d ':' | sudo xargs -L 1 deluser --group `

## 2. Persist the solution

1. [] Install as @reboot cronjob, service or init script

