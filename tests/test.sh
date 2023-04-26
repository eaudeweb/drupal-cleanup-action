#!/bin/sh

rm -rf release-* dir-*
mkdir -p release-001/web/core/modules/update/tests/fixtures/release-history
mkdir -p release-002/web/core/modules/update/tests/fixtures/release-history
mkdir -p release-003/web/core/modules/update/tests/fixtures/release-history
mkdir -p release-004/web/core/modules/update/tests/fixtures/release-history
mkdir -p release-005/web/core/modules/update/tests/fixtures/release-history
mkdir -p release-006/web/core/modules/update/tests/fixtures/release-history
mkdir -p release-007/web/core/modules/update/tests/fixtures/release-history

set -e

touch -t `date +%y%m%d%H%M.%S`              release-001
touch -t `date +%y%m%d%H%M.%S -d "-1 hour"` release-002
touch -t `date +%y%m%d%H%M.%S -d "-1 day"`  release-003
touch -t `date +%y%m%d%H%M.%S -d "-2 day"`  release-004
touch -t `date +%y%m%d%H%M.%S -d "-3 day"`  release-005
touch -t `date +%y%m%d%H%M.%S -d "-4 day"`  release-006
touch -t `date +%y%m%d%H%M.%S -d "-5 day"`  release-007

touch -t `date +%y%m%d%H%M.%S`              database-before-release-001.sql.gz
touch -t `date +%y%m%d%H%M.%S -d "-1 hour"` database-before-release-002.sql.gz
touch -t `date +%y%m%d%H%M.%S -d "-1 day"`  database-before-release-003.sql.gz
touch -t `date +%y%m%d%H%M.%S -d "-2 day"`  database-before-release-004.sql.gz
touch -t `date +%y%m%d%H%M.%S -d "-3 day"`  database-before-release-005.sql.gz
touch -t `date +%y%m%d%H%M.%S -d "-4 day"`  database-before-release-006.sql.gz
touch -t `date +%y%m%d%H%M.%S -d "-5 day"`  database-before-release-007.sql.gz

mkdir dir-001 dir-002 dir-003 dir-004
touch -t `date +%y%m%d%H%M.%S -d "-1 hour"` dir-002
touch -t `date +%y%m%d%H%M.%S -d "-1 day"`  dir-003
touch -t `date +%y%m%d%H%M.%S -d "-2 day"`  dir-004

../cleanup.sh "*release-*" 5

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

if [ ! -f "database-before-release-001.sql.gz" ]; then
 echo "File database-before-release-001.sql.gz not found ... fail"
 exit 3
fi

if [ ! -f "database-before-release-002.sql.gz" ]; then
 echo "File database-before-release-002.sql.gz not found ... fail"
 exit 3
fi

if [ ! -f "database-before-release-003.sql.gz" ]; then
 echo "File database-before-release-003.sql.gz not found ... fail"
 exit 3
fi

if [ ! -f "database-before-release-004.sql.gz" ]; then
 echo "File database-before-release-004.sql.gz not found ... fail"
 exit 3
fi

if [ ! -f "database-before-release-005.sql.gz" ]; then
 echo "File database-before-release-005.sql.gz not found ... fail"
 exit 3
fi

###

if [ -f "database-before-release-006.sql.gz" ]; then
 echo "File database-before-release-006.sql.gz found ... fail"
 exit 3
fi

if [ -f "database-before-release-007.sql.gz" ]; then
 echo "File database-before-release-007.sql.gz found ... fail"
 exit 3
fi

##

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
