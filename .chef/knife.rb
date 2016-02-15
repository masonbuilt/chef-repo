log_level                :info
log_location             STDOUT
node_name                'mzemel'
client_key               '~/Sites/chef-repo/.chef/mzemel.pem'
validation_client_name   'chef-validator'
validation_key           '~/Sites/chef-repo/.chef/masonbuilt-validator.pem'
chef_server_url          'https://api.opscode.com/organizations/masonbuilt'
syntax_check_cache_path  '~/Sites/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '~/Sites/chef-repo//cookbooks', '~/.berkshelf/cookbooks' ]
