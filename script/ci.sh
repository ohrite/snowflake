#!/bin/bash

BASE_PATH=`cd $(dirname $0)/.. && pwd`

time $BASE_PATH/vendor/roundup/roundup.sh
