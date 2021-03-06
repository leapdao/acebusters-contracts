#!/usr/bin/env bash

# Based on https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/scripts/test.sh

# Executes cleanup function at script exit.
trap cleanup EXIT

cleanup() {
  # Kill the testrpc instance that we started (if we started one and if it's still running).
  if [ -n "$testrpc_pid" ] && ps -p $testrpc_pid > /dev/null; then
    kill -9 $testrpc_pid
  fi
}

testrpc_running() {
  nc -z localhost 8545
}

if testrpc_running; then
  echo "Using existing testrpc instance"
else
  echo "Starting our own testrpc instance"
  testrpc --account="0x278a5de700e29faae8e40e366ec5012b5ec63d36ec77e8a2417154cc1d25383f,999999999999999999999" --account="0x7bc8feb5e1ce2927480de19d8bc1dc6874678c016ae53a2eec6a6e9df717bfac,999999999999999999999", --account="0x71d2b12dad610fc929e0596b6e887dfb711eec286b7b8b0bdd742c0421a9c425,999999999999999999999" --account="0x94890218f2b0d04296f30aeafd13655eba4c5bbf1770273276fee52cbe3f2cb4,999999999999999999999" > /dev/null &
  testrpc_pid=$!
fi

node_modules/.bin/truffle test "$@"
