# For each new server:

1.  Set up new users (mason, deploy) aside from root.
2.  Put public key in authorized_keys for root, mason, and deploy
3.  Edit `/etc/ssh/sshd_config` to accept SSH over port 1138 and set `PermitRootLogin no` & `AllowUsers mason deploy`. Restart with `sudo service ssh reload`
4.  Change project name references in `cookbooks/masonbuilt-server/default/unicorn.erb` and `cookbooks/masonbuilt-server/default/unicorn.erb`
4.  Bootstrap node and run chef-client (see below)

### Bootstrapping

From this directory, make sure `.chef/knife.rb` is configured correctly.

`knife node create [new node name] --editor nano`

`knife bootstrap [ip address] --sudo -x [user] -P [password] -N [new node name]`

### Chef-client

`knife node edit [node name]`

Add:

```ruby
"run_list": [
  "recipe[masonbuilt-server::default]"
]
```

`knife ssh [ip address] 'sudo chef-client' -m -x [user] -P [password]`

# Other notes:

If cookbooks haven't been uploaded to the chef server yet, do that with:

`knife cookbook upload [cookbook name]` starting with "masonbuilt-server" and working backwards through dependency hell from there.


5.  Add server public key to my GitHub account since I can't figure out SSH forwarding

6.  In the project directory:

`cd [project]`
`scp -P 1138 config/nginx.conf deploy@[project].masonbuilt.com:/var/www/[project]/shared/config/`
Repeat for other linked files in the capistrano deploy.rb file manifest
`bundle exec cap production deploy:setup_config`

7.  In the `deploy` user on the server, add this to `~/.bashrc` just above the 'Exit if not interactive session line':

```
export RBENV_ROOT=/opt/rbenv
export PATH=/opt/rbenv/bin:$PATH
eval "$(rbenv init -)"
```

8.  Symlink config files on server since it's broken in capistrano:

```
cd /var/www/sendero/current
ln -nfs /var/www/sendero/shared/config/unicorn.rb config/
```

9.  `bundle exec cap production deploy`

10.  On the server, `bundle exec rake db:migrate` b/c for some reason it's not doing that as part of the deploy process.

NOTE: Redis has been removed for now - for being a PITA.

web.json doesn't work but it's probably going to be used for the server recipe