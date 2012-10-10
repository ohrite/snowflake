directory () {
  if [ "$2" = "do" ]
  then
    permissions=0700
    directory_path="$1"
    owner=

    mode () {
      permissions="$1"
    }

    owner () {
      owner="$1"
    }

    end () {
      mkdir -m "$permissions" -p "$directory_path"
      if [ -n "$owner" ]
      then
        chown "$owner" "$directory_path" || sudo chown "$owner" "$directory_path"
      fi
      unset mode end permissions directory_path owner
    }
  else
    mkdir -p "$1"
  fi
}
