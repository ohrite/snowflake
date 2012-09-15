MODULES=

if [ -z "$SNOWFLAKE_PATH" ]
then
  SNOWFLAKE_PATH=`cd $(dirname $0) && pwd`/lib
fi

module () {
  local split_snowflake_path=`echo $SNOWFLAKE_PATH | tr ":" "\n"`

  resolve_dependency () {
    for path in $split_snowflake_path
    do
      if [ -e "$path/$1.sh" ]
      then
        . "$path/$1.sh"
        return 0
      fi
    done
    return 1
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
    while [ $# -gt 0 ]
    do
      if dependency_fits $1
      then
        if resolve_dependency $1
        then
          MODULES="$MODULES$1 "
        fi
      fi
      shift
    done
  }

  case "$1" in
    path)
      SNOWFLAKE_PATH="$SNOWFLAKE_PATH:$2"
      ;;

    list)
      echo $MODULES
      ;;

    depends)
      shift
      module_depends $@
      ;;

    *)
      return 1
      ;;
  esac
}
