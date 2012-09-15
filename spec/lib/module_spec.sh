. spec/spec_helper.sh

describe "module"

it_sets_a_MODULE_ROOT () {
  test "$MODULE_ROOT" != ""
}

it_has_no_modules_when_starting () {
  test -z "$current_modules"
}

it_can_depend_on_a_module () {
  module depends core/log
  current_modules=`module list`
  test "$current_modules" = "core/log"
}

it_does_not_expose_internal_functions () {
  for definition in `declare -F | cut -d" " -f3`
  do
    test "$definition" != "module_depends"
  done
}

it_does_not_depend_on_a_module_twice () {
  module depends core/log core/log
  current_modules=`module list`
  test "$current_modules" = "core/log"
}

it_does_not_depend_on_a_nonexistent_module () {
  module depends total_junk
  current_modules=`module list`
  test -z "$current_modules"
}
