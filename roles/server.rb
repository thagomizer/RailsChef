name "server"
description "the simple, bare necessities"

run_list(
  "recipe[ubuntu]",
  "recipe[apt]",
  "recipe[blog]",
  "recipe[nginx::source]",
  "recipe[user::data_bag]",
  "recipe[users::sysadmins]",
  "recipe[sudo]",
  "recipe[git]",
  "recipe[vim]",
)

default_attributes({
  :nginx => {
    :install_method => 'source',
    :version => '1.4.0',
    :server_tokens => "off",
  },
  :ssh => {
    :port => 22
  },
  :users => ['deploy'], # to create, for recipe[user::data_bag]
  :authorization => {   # recipe[users::sysadmins]
    :sudo => {
      :users => ["ubuntu", "deploy"], #TODO make this environment specific
      :passwordless => true
    }
  },
  :deploy_user => 'deploy',
})
