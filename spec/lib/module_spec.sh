. spec/spec_helper.sh

describe "core/module"

it_has_no_modules_when_starting () {
  test "$MODULES" = ""
}

it_can_depend_on_a_module () {
  module depends core/log
  test "$MODULES" = "core/log "
}

it_does_not_expose_internal_functions () {
  for definition in `declare -F | cut -d" " -f3`
  do
    test "$definition" != "module_depends"
  done
}

it_does_not_import_a_module_twice () {
  module depends core/log
  module depends core/log
  test "$MODULES" = "core/log "
}
