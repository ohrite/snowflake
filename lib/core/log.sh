log () {
  timestamp () {
    date "+%Y-%m-%d %H:%M:%S"
  }

  local trace=
  local priority=DEBUG

  case `echo $1 | tr A-Z a-z` in
    trace)
      shift
      trace=" $1"
      shift
      ;;
    debug|info|warn|error)
      priority=`echo $1 | tr a-z A-Z`
      shift
      ;;
  esac

  if [ $# -gt 0 ]
  then
    echo "[`timestamp`$trace] $priority - $@"
  fi
}
