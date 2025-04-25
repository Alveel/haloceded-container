#!/bin/env bash

if [ "$1" = "haloceded" ]; then
  # Run Halo server with wine in a virtual frame buffer
   xvfb-run wine cmd /c haloceded.exe -exec data/init.txt
else
  # If the first argument is not "haloceded", try to execute the command
  exec "$@"
fi

