#!/usr/bin/env bash

arg1="$*" # all text after command
if [ "$arg1" = "" ]; then
	echo "Please use \"./upload.sh description of changes\""
	exit 1
fi

git add . && (
	git commit -m "$arg1"
	git push gitlab
	git push github
)
