#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Convert to youtube embed because asciinema doesn not render properly on phones

here="$(dirname ${BASH_SOURCE[0]})"
cd "$here"

upload=$(asciinema upload presentation.json)
api_url=$(echo "$upload" | sed 's_/a/_/api/asciicasts/_')

cd asciinema2mp4
./asciinema2mp4 -o ../presentation.mp4 "$api_url"
