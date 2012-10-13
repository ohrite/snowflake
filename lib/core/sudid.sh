sudid () {
  case "$1" in
    do)
      shift
      sudo $@
      ;;
    try)
      shift
      $@ || sudo $@
      ;;
  esac
}
