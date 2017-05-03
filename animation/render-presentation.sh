#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Convert to youtube embed because asciinema doesn not render properly on phones

here="$(dirname ${BASH_SOURCE[0]})"
cd "$here"

upload=$(asciinema upload presentation.json)
api_url=$(echo "$upload" | sed 's_/a/_/api/asciicasts/_')

# Without this delay the api appears to not serve
#   use size information correctly (I think there is a race
#   condition of the server)
sleep 10;


cd asciinema2mp4
./asciinema2mp4 --size big -o ../presentation.mp4 "$api_url"
