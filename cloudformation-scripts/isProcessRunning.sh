#!/bin/bash

ret=0
if pgrep -x "$1" > /dev/null
then
    ret=1
else
    ret=0
fi

exit $ret