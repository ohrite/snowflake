. spec/spec_helper.sh

describe "template/esh"

it_lets_me_embed_a_template () {
  template_output=`esh template <<end
    I'm line one.
    Line two here
end`
  first_template_line=`echo "$template_output" | head -n1`
  test "$first_template_line" = "    I'm line one."
}

it_lets_me_assign_a_template_to_a_variable () {
  esh template template_output <<end
    yo i got your variable
end
  test "$template_output" = "    yo i got your variable"
}

it_lets_me_use_embedded_shell_in_a_script () {
  esh template template_output <<end
\`pwd\`
end
  esh_inspect_output=`esh inspect template_output`
  test "$esh_inspect_output" = "\`pwd\`"

  esh_result_output=`esh result template_output`
  test "$esh_result_output" = "`pwd`"
}
