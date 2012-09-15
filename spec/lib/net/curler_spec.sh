. spec/spec_helper.sh

describe "net/curler"

it_can_grab_a_file () {
  curler_output=`curler https://raw.github.com/ohrite/snowflake/master/README.md`
  echo $curler_output | head -n1 | grep "^# Snowflake"
}
