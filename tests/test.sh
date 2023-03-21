#!/bin/sh

rm -rf release-* dir-*
mkdir release-001 release-002 release-003 release-004 release-005 release-006 release-007

set -e

touch -t `date +%y%m%d%H%M.%S` 				release-001
touch -t `date +%y%m%d%H%M.%S -d "-1 hour"`	release-002
touch -t `date +%y%m%d%H%M.%S -d "-1 day"`	release-003
touch -t `date +%y%m%d%H%M.%S -d "-2 day"`	release-004
touch -t `date +%y%m%d%H%M.%S -d "-3 day"` 	release-005
touch -t `date +%y%m%d%H%M.%S -d "-4 day"` 	release-006
touch -t `date +%y%m%d%H%M.%S -d "-5 day"` 	release-007

mkdir dir-001 dir-002 dir-003 dir-004
touch -t `date +%y%m%d%H%M.%S -d "-1 hour"`	dir-002
touch -t `date +%y%m%d%H%M.%S -d "-1 day"`	dir-003
touch -t `date +%y%m%d%H%M.%S -d "-2 day"`	dir-004

../cleanup.sh "release-*" 5

if [ ! -d "release-001" ]; then
 echo "Directory release-001 not found ... fail"
 exit 3
fi

if [ ! -d "release-002" ]; then
 echo "Directory release-002 not found ... fail"
 exit 3
fi

if [ ! -d "release-003" ]; then
 echo "Directory release-003 not found ... fail"
 exit 3
fi

if [ ! -d "release-004" ]; then
 echo "Directory release-004 not found ... fail"
 exit 3
fi

if [ ! -d "release-005" ]; then
 echo "Directory release-005 not found ... fail"
 exit 3
fi

###

if [ -d "release-006" ]; then
 echo "Directory release-006 found ... fail"
 exit 3
fi

if [ -d "release-007" ]; then
 echo "Directory release-007 found ... fail"
 exit 3
fi

###

if [ ! -d "dir-001" ]; then
 echo "Directory dir-001 not found ... fail"
 exit 3
fi

if [ ! -d "dir-002" ]; then
 echo "Directory dir-002 not found ... fail"
 exit 3
fi

if [ ! -d "dir-003" ]; then
 echo "Directory dir-003 not found ... fail"
 exit 3
fi

if [ ! -d "dir-004" ]; then
 echo "Directory dir-004 not found ... fail"
 exit 3
fi


echo ""
echo "Success"