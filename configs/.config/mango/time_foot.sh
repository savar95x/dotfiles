#!/bin/bash
start=$(date +%s%N)
foot -e sh -c "end=\$(date +%s%N); echo 'End-to-End Startup Time: '\$(( (end - $start) / 1000000 ))' ms'; exec zsh"
