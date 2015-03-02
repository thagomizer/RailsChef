name "db-server"
description "Blog DB server."

run_list(
  "role[server]",
  "role[mysql_server]"
  )
