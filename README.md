# For each new server:

1.  Set up new users (mason, deploy) aside from root
2.  Put public key in authorized_keys for root, mason, and deploy
3.  Change ssh port and disable root ssh login
4.  Change project name references in `cookbooks/masonbuilt-cookbook/default/unicorn.erb` and `cookbooks/masonbuilt-cookbook/default/unicorn.erb`
4.  Bootstrap node and run chef-client (see below)
5.  Deploy with capistrano

### Bootstrapping

From this directory, make sure `.chef/knife.rb` is configured correctly.

`knife node create [new node name] --editor nano`

`knife bootstrap [ip address] --sudo -x [user] -P [password] -N [new node name]`

### Chef-client

`knife node edit [node name]`

Add:

```ruby
"run_list": [
  "recipe[masonbuilt-cookbook::default]"
]
```

`knife ssh [ip address] 'sudo chef-client' -m -x [user] -P [password]`

# Other notes:

If cookbooks haven't been uploaded to the chef server yet, do that with:

`knife cookbook upload [cookbook name]` starting with "masonbuilt-cookbook" and working backwards through dependency hell from there.

NOTE: Redis has been removed for now - for being a PITA.