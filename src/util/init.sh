#!/usr/bin/env bash

INFO=1
ERROR=1
DEBUG=0

function __init {
	# Make this script exit when any command fails
	set -o errexit

	# Make this script exit when usigng undeclared variable
	set -o nounset

	# Make this script throw first non-zero exit code in pipe
	set -o pipefail

	if [[ "$*" == *--debug* ]]
	then
		DEBUG=1
	fi
}
