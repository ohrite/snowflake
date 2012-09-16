#!/bin/sh
curl -s https://raw.github.com/ohrite/snowflake/master/bin/install | sh
tail -n+`awk '/^__CLOBBER_FILE__/ {print NR + 1; exit 0; }' $0` $0 | snowflake && exit 0
__CLOBBER_FILE__

module depends core/log

log "okay, i'm in the file."
log info "here's another line"
