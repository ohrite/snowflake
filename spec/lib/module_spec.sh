. spec/spec_helper.sh

describe "module"

before () {
  temporary_directory=`mktemp -d -t module`
}

after () {
  rm -rf $temporary_directory
}

it_has_no_modules_when_starting () {
  test -z "`module list`"
}

it_can_depend_on_a_module () {
  module depends core/log
  current_modules=`module list`
  test "$current_modules" = "core/log"
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

it_can_depend_on_a_module_absolutely () {
  mkdir "$temporary_directory/fake"
  touch "$temporary_directory/fake/module.sh"
  touch "$temporary_directory/fake/other_module.sh"

  module depends fake/module
  test -z "`module list`"

  module path $temporary_directory
  module depends fake/module fake/other_module fake/not_a_module
  test "`module list`" = "fake/module fake/other_module"
}
