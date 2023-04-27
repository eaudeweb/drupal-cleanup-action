#!/bin/sh

# Delete a pattern of directories from the current directory leaving only the newest x folders

set -e

pattern=unset
leave=unset
remove=1

usage()
{
  echo "Usage: ./cleanup.sh [ -s | --simulate ] <pattern> <x>

Options:
    -s | --simulate  - Do not delete anything, just output


    <pattern>        - Delete the folders starting with this pattern (use \"\")
    x                - number of newest folders to retain

Examples:
	./cleanup.sh \"release-\" 5     - Delete old folders starting with release-
	                                and leave the newest 5
	./cleanup.sh -s \"release-\" 2  - Show what folders would be deleted
"
  exit 2
}


PARSED_ARGS=$(getopt -a -n cleanup.sh -o s --long simulate -- "$@")
eval set -- "$PARSED_ARGS"

VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

while :
do
  case "$1" in
    -s | --simulate)   remove=0  ; shift   ;;
    --) shift; break ;;
    *) echo "Unexpected option: $1"
       usage ;;
  esac
done

pattern="$1"
leave="$2"

if [ "$remove" != "1" ]; then
	echo "WARNING! SIMULATION, nothing will be deleted"
fi

if [ $# -ne 2 ]; then
	usage
	exit 2
fi

if [ ! $leave -ge 1 ]; then
	echo "You must leave at least one folder ..."
	exit 2
fi

echo "Cleanup $pattern, leaving only the newest $leave directories:"

directories=$(find . -maxdepth 1 -type d ! -path . -name "$pattern" -printf "%T@ %p\n" | sort -rn | cut -d" " -f2)

skip=0
for i in $directories; do
	skip=$((skip+1))
	if [ $skip -gt $leave ]; then
		echo "    * Deleting $i"
		if [ "$remove" = "1" ]; then
			echo "    * Real deleting $i"
			rm -rf "$i"
		fi
	fi
done

echo "Cleanup $pattern, leaving only the newest $leave files:"

files=$(find . -maxdepth 1 -type f ! -path . -name "$pattern" -printf "%T@ %p\n" | sort -rn | cut -d" " -f2)

skip=0
for i in $files; do
	skip=$((skip+1))
	if [ $skip -gt $leave ]; then
		echo "    * Deleting $i"
		if [ "$remove" = "1" ]; then
			echo "    * Real deleting $i"
			rm -rf "$i"
		fi
	fi
done

echo "Done."
echo "-------"
echo "Remaining files and directories:"
ls -d $pattern
