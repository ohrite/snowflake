. spec/spec_helper.sh

describe "core/external"

it_is_able_to_depend_on_a_gist () {
  external gist 3729613
  module depends gist/3729613/sample
  test -n "`sample test`"
}
