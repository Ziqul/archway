#!/usr/bin/env bash

function __info() {
	[[ "${INFO}" == "1" ]] && echo "[INFO]: $*"
}

function __error() {
	[[ "${ERROR}" == "1" ]] && echo "[ERROR]: $*"
}

function __debug() {
	[[ "${DEBUG}" == "1" ]] && echo "[DEBUG]: $*"
}
