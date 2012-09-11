if [ -z "$MODULES_ROOT" ]
then  
  MODULES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

MODULES=

module () {
  add_dependency () {
    MODULES="$MODULES$1 "
  }

  dependency_fits () {
    for existing in $MODULES
    do
      if [ "$existing" = "$1" ]
      then
        return 1
      fi
    done
  }

  module_depends () {
    for dependency in "$@"
    do
      if dependency_fits $dependency
      then
        add_dependency $dependency
      fi
    done
  }

  case "$1" in
    depends)
      shift
      module_depends $@
      ;;
  esac
}
