. spec/spec_helper.sh

describe "core/log"

it_logs_a_message_with_a_timestamp () {
  log_output=`log 'various meats'`
  echo "$log_output" | grep "^\[\d*-\d*-\d* \d*:\d*:\d*]"
  log_message=`echo "$log_output" | cut -f 2 -d"]" -`
  test "$log_message" = " DEBUG - various meats"
}

it_sets_a_trace_name () {
  log_output=`log trace YODAWG 'various meats'`
  echo "$log_output" | cut -f 1 -d"]" - | grep "YODAWG$"
}

it_sets_a_logging_priority () {
  log_output=`log info 'various meats'`
  log_message=`echo "$log_output" | cut -f 2 -d"]" -`
  test "$log_message" = " INFO - various meats"
}
