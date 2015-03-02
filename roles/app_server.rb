name "app_server"
description "rails application server"

run_list(
  "role[rails_server]",
  "recipe[mysql::client]",
  )

default_attributes ({
    :application_name => "blog",
    :deploy_to => "/var/www/blog"
  })
