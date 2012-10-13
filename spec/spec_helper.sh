SNOWFLAKE_PATH=`pwd`/"lib"

# module dependency on top of roundup's describe()
describe_module () {
  describe "$@"
  source lib/module.sh
  module depends $@
}

write_declares () {
  local ignores
  for ignore in BASH_LINENO FUNCNAME SHELLOPTS
  do
    ignores="$ignores | grep -v $ignore"
  done
  eval "declare $ignores > $1"
}
