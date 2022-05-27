#!/usr/bin/env bash

set -e

dir="$(dirname $0)"

setup_apt () {
	echo "Setting up $NAME $VERSION_CODENAME"

	# Give a little time for a frantic CTRL-C, if needed :-)
	sleep 5

	readarray -t packages < "$dir/packages.apt"
	sudo apt update
	sudo apt upgrade
	sudo apt install -y "${packages[@]}"
}

setup_pip3 () {
	pip3 install -r "$dir/packages.pip3"
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

setup_pip3
