profile () {
  local path_parts

  extract_path () {
    old_ifs="$IFS"
    IFS=":"
    set -- $PATH
    path_parts=$@
    IFS="$old_ifs"
  }

  remove_part () {
    local accepted_parts=""

    for part in $path_parts
    do
      if [ "$part" != "$1" ]
      then
        accepted_parts="$accepted_parts $part"
      fi
    done

    path_parts="$accepted_parts"
  }

  present_path () {
    while [ $# -gt 0 ]
    do
      printf $1
      if [ $# -gt 1 ]
      then
        printf ":"
      fi

      shift
    done
  }

  case "$1" in
    path)
      extract_path
      present_path $path_parts
      ;;
    path_without)
      extract_path
      remove_part $2
      present_path $path_parts
  esac
  
  unset path_parts present_path extract_path remove_part
}