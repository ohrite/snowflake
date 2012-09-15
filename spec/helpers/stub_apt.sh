test_packages=

dpkg () {
  case "$1" in
    --get-selections)
      echo $test_packages
      ;;
  esac
}

sudo () {
  case "$1" in
    apt-get)
      shift
      case "$1" in
        install)
          shift
          test_packages="$test_packages $@"
          ;;
      esac
      ;;
    *)
      eval $@
      ;;
  esac
}
