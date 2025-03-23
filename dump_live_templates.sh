#!/bin/bash

curl -sLO https://sourcegraph.com/github.com/JetBrains/intellij-community/-/raw/resources/src/liveTemplates/Java.xml

python - <<EOF
import sys
import xml.etree.ElementTree as ET
xmls='''
<root>
$(xmllint --format --xpath '//template' Java.xml)
</root>
'''
for template in ET.fromstring(xmls).iter('template'):
  sys.stdout.write(template.attrib['name'] + '\t' + template.attrib['value'] + '\t\n')
EOF
