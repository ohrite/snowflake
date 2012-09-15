MODULES=

if [ -z "$MODULE_ROOT" ]
then
  MODULE_ROOT=`cd $(dirname $0) && pwd`
fi

module () {
  add_dependency () {
    if [ -e "$MODULE_ROOT/$1.sh" ]
    then
      MODULES="$MODULES$1 "
    fi
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
    list)
      echo $MODULES
      ;;
    depends)
      shift
      module_depends $@
      ;;
  esac
}
