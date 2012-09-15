yum_package () {
  case "$1" in
    install)
      shift
      sudo yum -y install $1
      ;;

    has)
      shift
      if yum -y list | grep -v $1
      then
        return 1
      fi
      ;;

    *)
      return 1
      ;;
  esac
}
