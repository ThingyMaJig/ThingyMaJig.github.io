#!/bin/bash

INFILE="$1"

while read LINE; do
  NAME=${LINE%%,*}
  LINE=${LINE#*,}

  SLUG=${LINE%%,*}

  DESC=${LINE#*,}

  OUTPUT="---
slug: $SLUG
name: $NAME
---
$DESC"

  echo "Making template for ${SLUG}.md"

  echo "$OUTPUT" > "${SLUG}.md"

done < $INFILE