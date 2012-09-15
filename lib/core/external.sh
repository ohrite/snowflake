if [ -z "$SNOWFLAKE_CACHE" ]
then
  SNOWFLAKE_CACHE=/tmp/snowflake/cache
fi

external () {
  SNOWFLAKE_PATH=$SNOWFLAKE_PATH:$SNOWFLAKE_CACHE

  local gist_cache_path="$SNOWFLAKE_CACHE/gist"

  mkdir -p "$gist_cache_path"

  download_gist () {
    local temp_gist=`mktemp -t gist`

    if curler "https://gist.github.com/gists/$1/download" -o "$temp_gist"
    then
      local gist_path=`tar -tf "$temp_gist" | head -n1`
      cd "$gist_cache_path"
      tar -zxf "$temp_gist"
      rm -f "$gist_cache_path/$1"
      ln -s "$gist_cache_path/$gist_path" "$gist_cache_path/$1"
    fi

    rm -rf "$temp_gist"
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
}
