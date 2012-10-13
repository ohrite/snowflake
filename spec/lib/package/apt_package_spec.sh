. spec/spec_helper.sh

describe_module "package/apt_package"

before () {
  if [ -z "`which dpkg`" ]
  then
    . spec/helpers/stub_apt.sh
  fi
}

it_determines_if_a_package_is_installed () {
  if apt_package has nonexistent
  then
    return 1
  fi
}

it_installs_an_apt_package () {
  apt_package install nginx
  apt_package has nginx
}
