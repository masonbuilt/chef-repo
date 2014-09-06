#### Thing to remember

`knife configure initial`

Reset validator key and client key.  Figure out wtf they do.

Configure `.chef/knife.rb` correctly.

**Make node:**
`knife node create [new node name] --editor nano`

Put recipes in the run list.

**Bootstrap:**
`knife bootstrap [ip address] --sudo -x [user] -P [password] -N [new node name]`

**Run chef-client:**
`knife ssh [ip address] 'sudo chef-client' -m -x [user] -P [password]`