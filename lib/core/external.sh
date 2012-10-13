if [ -z "$SNOWFLAKE_CACHE" ]
then
  SNOWFLAKE_CACHE=/tmp/snowflake/cache
fi

module depends net/curler

external () {
  SNOWFLAKE_PATH="$SNOWFLAKE_PATH:$SNOWFLAKE_CACHE"

  extract_file () {
    local gist_path=`tar -tf "$1" | head -n1`

    mkdir -p "$2"
    cd "$2"
    tar -zxf "$1"

    if [ -n "$3" ]
    then
      rm -f "$3"
      ln -s "$gist_path" "$3"
    fi
  }

  download_and_extract () {
    local tarball=`mktemp -t tarball`

    if curler "$1" -o "$tarball"
    then
      shift
      extract_file "$tarball" $@
      rm -f "$tarball"
    else
      rm -f "$tarball"
      return 1
    fi
  }

  download_gist () {
    download_and_extract "https://gist.github.com/gists/$1/download" \
                         "$SNOWFLAKE_CACHE/gist" \
                         "$SNOWFLAKE_CACHE/gist/$1"
  }

  case "$1" in
    gist)
      shift
      download_gist $@
      ;;

    *)
      return 1
      ;;
  esac
  unset extract_file download_gist download_and_extract
}
