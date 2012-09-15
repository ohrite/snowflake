test_packages=

yum () {
  if [ "$1" = "-y" ]
  then
    shift
  fi

  case "$1" in
    install)
      test_packages="$test_packages $@"
      ;;
    list)
      echo $test_packages
      ;;
    *)
      return 1
      ;;
  esac
}

sudo () {
  case "$1" in
    yum)
      shift
      yum $@
      ;;
    *)
      eval $@
      ;;
  esac
}
