. spec/spec_helper.sh

describe "chef/directory"

before () {
  DIRECTORY_SANDBOX=`mktemp -d -t cache`
}

after () {
  sudo rm -rf $DIRECTORY_SANDBOX
}

it_creates_a_path_with_a_single_argument () {
  directory "$DIRECTORY_SANDBOX/mudbutt"
  test -d "$DIRECTORY_SANDBOX/mudbutt"
}

it_creates_a_path_with_a_block () {
  directory "$DIRECTORY_SANDBOX/hermit_crab" do
  end
  test -d "$DIRECTORY_SANDBOX/hermit_crab"
}

it_creates_a_path_with_mode () {
  directory "$DIRECTORY_SANDBOX/filthy-slapper" do
    mode 0666
  end
  permissions=`ls -l "$DIRECTORY_SANDBOX" | tail -n1 | cut -d' ' -f1`
  test "$permissions" = "drw-rw-rw-"
}

it_creates_a_path_with_an_owner () {
  directory "$DIRECTORY_SANDBOX/hangover" do
    owner "nobody"
  end
  owner=`stat "$DIRECTORY_SANDBOX/hangover" | cut -d' ' -f5`
  test "$owner" = "nobody"
}
