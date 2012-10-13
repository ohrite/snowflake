. spec/spec_helper.sh

describe_module "core/dsl"

it_defines_setters_for_fields () {
  dsl setters irish
  setter_type=`type irish | head -n 1`
  test "$setter_type" = "irish is a function"
}

it_gets_a_field () {
  dsl setters scottish
  scottish "hairy"
  value=`dsl get scottish`
  test "$value" = "hairy"
}

it_clears_all_fields () {
  dsl setters welsh
  dsl clear
  type welsh 2>&1 | grep "welsh: not found"
}
