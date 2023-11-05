#!/bin/bash

echo "START TIME: $(date +%s)"

# **************************** DECLARE GLOBAL VARIABLES for Joat Shell *****************************

export JOAT_SHELL_DEST=${JOAT_SHELL_DEST:-/}
export JOAT_SHELL_ALLOWING_PARALLEL=True

# *********************************** Import Joat Shell packages ***********************************

source ./functions_common
source ./inc/ini_config
source ./inc/async

# ******************************* FAKE FUNCTIONS are used for testing ******************************

sleeping_10s() {
  echo "Sleeping 10s"
  sleep 10
  echo "Wake up after 10s"
}

sleeping_5s() {
  echo "Sleeping 5s"
  sleep 5
  echo "Wake up after 5s"
}

# Create and/or clean the async state directory
async_init

# Run a function in the background
async_runfunc sleeping_10s
async_runfunc sleeping_5s

# Wait for all async functions to complete
async_wait sleeping_10s sleeping_5s

echo "All async functions have completed, now I need to clean up the async state directory"

# Joat-Shell clean up the async state directory
async_cleanup

# Show the timing summary
async_print_timing

echo "END TIME: $(date +%s)"