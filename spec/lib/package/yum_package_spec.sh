. spec/spec_helper.sh

describe "package/yum_package"

before () {
  if [ -z "`which yum`" ]
  then
    . spec/helpers/stub_yum.sh
  fi
}

it_determines_if_a_package_is_installed () {
  if yum_package has nonexistent
  then
    return 1
  fi
}

it_installs_a_package () {
  yum_package install nginx
  yum_package has nginx
}
