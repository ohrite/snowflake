dsl () {
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
  esac
  unset setters get clear
}
