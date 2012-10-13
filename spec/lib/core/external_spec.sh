. spec/spec_helper.sh

describe_module "core/external"

before () {
  SNOWFLAKE_CACHE=`mktemp -d -t cache`
}

after () {
  rm -rf $SNOWFLAKE_CACHE
}

it_is_able_to_depend_on_a_gist () {
  external gist 3729613
  module depends gist/3729613/sample
  test "`sample test`" = "Successfully ran sample test!"
}
