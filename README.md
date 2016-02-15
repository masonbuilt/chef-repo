# For each new server:

1.  Set up new users (mason, deploy) aside from root
2.  Put public key in authorized_keys for root, mason, and deploy
3.  Change ssh port and disable root ssh login

# To set up a new node:

`knife configure initial` if not done already.

Reset validator key and client key if need be in [Chef console](http://manage.chef.io)

Configure `.chef/knife.rb` correctly.

`knife node create [new node name] --editor nano`

Put recipes in the run list: `knife node edit [node name]`

**Bootstrap:**
`knife bootstrap [ip address] --sudo -x [user] -P [password] -N [new node name]`

**Run chef-client:**
`knife ssh [ip address] 'sudo chef-client' -m -x [user] -P [password]`

### Cookbooks

If they haven't been  uploaded to the chef server yet, do that with:

`knife cookbook upload [cookbook name]`

Many have dependencies which have to be uploaded first