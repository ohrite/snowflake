dsl () {
  arguments () {
    local setter=$1
    shift

    while [ $# -gt 0 ]
    do
      if [ $# -eq 1 -a "$1" = "do" ]
      then
        return 1
      fi

      eval "dsl_variable_$setter=\"\${dsl_variable_$setter}$1 \""
      shift
    done
  }

  setters () {
    for field in $@
    do
      eval "function $field { dsl_variable_$field=\$@; }"
      dsl_variables="$dsl_variables $field"
    done
  }

  get () {
    eval "echo \$dsl_variable_$1"
  }

  clear () {
    for field in $dsl_variables
    do
      eval "unset $field"
    done
    unset dsl_variables
  }

  case "$1" in
    setters)
      shift
      setters $@
      ;;
    get)
      shift
      get $@
      ;;
    clear)
      clear
      ;;
    arguments)
      shift
      if ! arguments $@
      then
        unset setters get clear arguments
        return 1
      fi
      ;;
  esac
  unset setters get clear arguments
}
