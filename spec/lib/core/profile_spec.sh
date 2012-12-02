. spec/spec_helper.sh

describe_module "core/profile"

it_prints_the_path () {
  output=`profile path`
  test "$output" = $PATH
}

it_prints_the_path_without_usr_local_bin () {
  PATH="/beans:/usr/local/bin:/meat@dinner"
  output=`profile path_without /usr/local/bin`
  test "$output" = "/beans:/meat@dinner"
}
