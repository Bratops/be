set :stage, :production
set :branch, "master"

set :deploy_to, "/home/#{fetch(:deployer)}/app/#{fetch(:application)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :production

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_workers, 8

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{nsn@bebras01.csie.ntnu.edu.tw}
role :web, %w{nsn@bebras01.csie.ntnu.edu.tw}
role :db,  %w{nsn@bebras01.csie.ntnu.edu.tw}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.
#server "bebras01.csie.ntnu.edu.tw", user: 'nsn', roles: %w{web app}, my_property: :my_value


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  port: 18324,
  auth_methods: %w(publickey)
}

#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
