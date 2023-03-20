#!/bin/sh

# Delete a pattern of directories from the current directory leaving only the newest x folders

pattern=$1
leave=$2

if [ $# -ne 2 ]; then
	echo "Usage: ./cleanup.sh <pattern> <x>"
	echo ""
	echo "where:"
	echo "    <pattern> a directory pattern"
	echo "    <x> - a number of newest folders to leave, must be >= 1"
	echo ""
	echo 'Example: ./cleanup.sh "release-*" 3'
	echo "    Delete all directories starting with release- and leave only the newest 3"
	exit 1
fi

if [ ! $leave -ge 1 ]; then
	echo "You must leave at least one folder ..."
	exit 2
fi

echo "Cleanup $pattern, leaving only the newest $leave directories:"

directories=$(find . -type d ! -path . -name "$pattern" -printf "%T@ %p\n" | sort -rn | cut -d" " -f2)

skip=0
for i in $directories; do
	skip=$((skip+1))
	if [ $skip -gt $leave ]; then
		echo "    * Deleting $i"
		rm -rf "$i"
	fi
done

echo "Done."
echo "-------"
echo "Remaining directories:"
ls -lt .|grep "$pattern"
