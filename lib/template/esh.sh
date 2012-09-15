esh () {
  create_template () {
    if [ -n "$1" ]
    then
      eval $1=\`cat\`
    else
      local create_template_output=
      eval create_template_output=\`cat\`
      inspect_template create_template_output
    fi
  }

  inspect_template () {
    local inspected_template=
    eval inspected_template=$`echo $1`
    echo "$inspected_template"
  }

  template_result () {
    eval echo "`inspect_template $1`"
  }

  case "$1" in
    template)
      shift
      create_template $@
      ;;

    inspect)
      inspect_template $2
      ;;

    result)
      template_result $2
      ;;
  esac
}
