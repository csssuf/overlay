# Overlay
Personal Gentoo overlay. Maybe you'll find something useful here too.

# Installing
Add an entry in `/etc/portage/repos.conf/csssuf.conf`:

```
[csssuf]
location = /usr/local/overlay/csssuf
sync-type = git
sync-uri = https://github.com/csssuf/overlay.git
```

See [here](https://wiki.gentoo.org/wiki//etc/portage/repos.conf) for more information on how to
configure overlays if you want to change anything.

# Contributing
PRs welcome. Please use `repoman` to make sure your ebuilds don't have issues.
