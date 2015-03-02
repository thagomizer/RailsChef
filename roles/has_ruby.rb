name "has_ruby"
description "Has ruby."

run_list("recipe[ruby_build]", "recipe[blog::ruby]")

default_attributes({
                     :ruby => "2.0.0-p451"
                   })
