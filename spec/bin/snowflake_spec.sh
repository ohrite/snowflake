. spec/spec_helper.sh

describe "snowflake"

it_can_run_a_script () {
  script="''module depends core/log && log debug hi there''"
  output=`bin/snowflake $script | cut -d"]" -f2`
  test "$output" = " DEBUG - hi there"
}
