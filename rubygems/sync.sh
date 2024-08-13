#!/bin/bash

set -x

export HOME=/root
cat << EOF > /root/.gem/.mirrorrc
---
- from: $UPSTREAM
  to: $TO
  parallelism: 10
  retries: 3
  delete: false
  skiperror: true
EOF

# Fetch index
wget -qO "$TO/versions.new" "$UPSTREAM/versions"
md5sum "$TO/versions.new" > "$TO/versions.md5sum.new"
mv -f "$TO/versions.new" "$TO/versions"
mv -f "$TO/versions.md5sum.new" "$TO/versions.md5sum"

exec gem mirror
