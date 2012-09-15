apt_package () {
  case "$1" in
    install)
      shift
      sudo apt-get install $1
      ;;

    has)
      shift
      if dpkg --get-selections | grep -v $1
      then
        return 1
      fi
      ;;

    *)
      return 1
      ;;
  esac
}
