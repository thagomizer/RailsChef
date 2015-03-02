name "mysql_server"
description "Mysql Server Base."

run_list(
  "role[server]",
  "recipe[mysql::server]",
         )

default_attributes({
  :mysql => {
    :server_root_password => 'asdfasdf',
    :server_debian_password => 'asdfasdf',
    :server_repl_password => 'asdfasdf'
  }
})
