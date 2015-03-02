name "rails_server"
description "Shared rails server"

run_list(
  "role[server]",
  "role[has_ruby]",
  "recipe[rails_nginx_unicorn]",
         )

default_attributes({
  :nginx => {
    'default_site_enabled' => false
  }
})
