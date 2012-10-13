. spec/spec_helper.sh

describe_module "chef/directory"

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

it_refuses_to_create_a_deep_path_nonrecursively () {
  directory "$DIRECTORY_SANDBOX/stinkditch/bbq" || : # trap error
  test ! -d "$DIRECTORY_SANDBOX/stinkditch/bbq"
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
  directory "$DIRECTORY_SANDBOX/dumpster" do
    owner "nobody"
  end
  owner=`stat "$DIRECTORY_SANDBOX/dumpster" | cut -d' ' -f5`
  test "$owner" = "nobody"
}

it_creates_a_path_recursively () {
  directory "$DIRECTORY_SANDBOX/hangover/flies/vomit" do
    recursive true
  end
  test -d "$DIRECTORY_SANDBOX/hangover/flies/vomit"
}

it_creates_a_path_with_action_create () {
  directory "$DIRECTORY_SANDBOX/adrenal-gland" do
    action "create"
  end
  test -d "$DIRECTORY_SANDBOX/adrenal-gland"
}

it_deletes_a_path_with_action_delete () {
  mkdir -p "$DIRECTORY_SANDBOX/rancid-tortoise"
  directory "$DIRECTORY_SANDBOX/rancid-tortoise" do
    action "delete"
  end
  test ! -d "$DIRECTORY_SANDBOX/rancid-tortoise"
}

it_refuses_to_delete_a_deep_path_nonrecursively () {
  mkdir -p "$DIRECTORY_SANDBOX/fatal/traffic"
  directory "$DIRECTORY_SANDBOX/fatal" do
    action "delete"
  end || : # trap error
  test -d "$DIRECTORY_SANDBOX/fatal/traffic"
}

it_deletes_a_deep_path_when_recursing () {
  mkdir -p "$DIRECTORY_SANDBOX/reproductive/problems/cancer"
  directory "$DIRECTORY_SANDBOX/reproductive" do
    recursive "true"
    action "delete"
  end
  test ! -d "$DIRECTORY_SANDBOX/reproductive/problems/cancer"
}
