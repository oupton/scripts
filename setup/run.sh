#!/usr/bin/env bash

set -e

setup_apt () {
	echo "Setting up $NAME $VERSION_CODENAME"

	# Give a little time for a frantic CTRL-C, if needed :-)
	sleep 5

	readarray -t packages < "$(dirname $0)/packages.apt"
	sudo apt update
	sudo apt upgrade
	sudo apt install -y "${packages[@]}"
}

. /etc/os-release

case $NAME in
	Debian)
		setup_apt
		;;
	Ubuntu)
		setup_apt
		;;
	*)
		echo "Unrecognized distribution: '$NAME'"
		exit 1
		;;
esac
