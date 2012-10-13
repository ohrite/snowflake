. spec/spec_helper.sh

describe_module "core/sudid"

it_escalates_privileges () {
  local sudo_input
  sudo () {
    sudo_input="$@"
  }

  sudid do echo hi from sudid
  test "$sudo_input" = "echo hi from sudid"
}

it_tries_to_run_before_escalating () {
  local sudo_input
  sudo () {
    sudo_input="$@"
  }

  sudid try mount /dev/ppp0
  test "$sudo_input" = "mount /dev/ppp0"
}
