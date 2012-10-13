module depends core/dsl core/log core/sudid

directory () {
  if [ $# -eq 1 ]
  then
    sudid try mkdir $1
    log debug "Executing create directory[`dsl get name`]"
    return 0
  fi

  dsl setters "owner" "mode" "recursive" "action" "path" "name"
  path "$1"
  name "$1"
  shift

  end () {
    if [ "`dsl get action`" = "delete" ]
    then
      if [ -n "`dsl get recursive`" -a "`dsl get recursive`" = "true" ]
      then
        sudid try rm -rf `dsl get path`
      else
        sudid try rmdir `dsl get path`
      fi
    else
      local options

      if [ -n "`dsl get recursive`" -a "`dsl get recursive`" = "true" ]
      then
        options="-p"
      fi

      if [ -n "`dsl get mode`" ]
      then
        options="$options -m `dsl get mode`"
      fi

      sudid try mkdir $options `dsl get path`

      if [ -n "`dsl get owner`" ]
      then
        sudid try chown `dsl get owner` `dsl get path`
      fi

      log debug "Executing create directory[`dsl get name`]"
    fi

    dsl clear
  }
}
