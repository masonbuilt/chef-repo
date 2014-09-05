# See http://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "mzemel"
client_key               "#{current_dir}/mzemel.pem"
validation_client_name   "stripstarter-validator"
validation_key           "#{current_dir}/stripstarter-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/stripstarter"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
