#!/bin/sh

set -eu

rerun --loglevel $RD_CONFIG_LOGLEVEL %MODULE%:%COMMAND% %OPTIONS%

exit $?