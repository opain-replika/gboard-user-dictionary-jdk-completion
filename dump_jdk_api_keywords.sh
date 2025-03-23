#!/bin/bash

# Run this in busybox or git bash on Windows
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
DOC_URL="https://download.oracle.com/otn_software/java/jdk/24+36/1f9ff9062db4449d8ca828c504ffae90/jdk-24_doc-all.zip"
INDEX_FILE_PATH='jdk-24_doc-all/docs/api/index-files'

# Download the zip file using curl with headers
curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" -o jdk-24_doc-all.zip "${DOC_URL}"

unzip -q jdk-24_doc-all.zip -d jdk-24_doc-all

for INDEX in ${SCRIPTPATH}/${INDEX_FILE_PATH}/index-*.html; do
# On Windows use Strawberry Perl or MSYS2 bundled xmllint.exe
xmllint \
  --format \
  --html \
  --xpath '//a[@class="member-name-link"]//text()' \
  ${INDEX} 2>/dev/null \
| sed \
  -e 's@&gt;@>@g' \
  -e 's@&lt;@<@g' \
| sort \
| uniq

done
