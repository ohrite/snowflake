. spec/spec_helper.sh

describe_module "core/dsl"

it_defines_setters_for_fields () {
  dsl setters irish
  setter_type=`type irish | head -n 1`
  test "$setter_type" = "irish is a function"
}

it_gets_a_field () {
  dsl setters scottish
  scottish "hairy"
  value=`dsl get scottish`
  test "$value" = "hairy"
}

it_clears_all_fields () {
  dsl setters welsh
  dsl clear
  type welsh 2>&1 | grep "welsh: not found"
}

it_puts_arguments_into_a_field () {
  icular () {
    dsl arguments pictish $@
  }
  icular gargling whiskey
  icular_output=`dsl get pictish`
  test "$icular_output" = "gargling whiskey"
}

it_provides_an_exit_code_path_for_blocks () {
  icular () {
    if dsl arguments cockney $@
    then
      echo "'ello `dsl get cockney`"
    fi
  }
  icular_shame=`icular filthy urchin`
  test "$icular_shame" = "'ello filthy urchin"
}

it_provides_an_exit_code_path_for_blocks () {
  icular () {
    if ! dsl arguments cockney $@
    then
      echo "up yer arse `dsl get cockney`!"
    fi
  }
  icular_shame=`icular mate do`
  test "$icular_shame" = "up yer arse mate!"
}
