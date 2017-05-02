#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# This is where we regret using asciinema
#  this is basically propriertyar SAAS with
#  a client.

# In order to render images to gif we have to upload
#  them and use the asciinema2gif tool

here="$(dirname ${BASH_SOURCE[0]})"
cd "$here"

animations=$(ls gallery-animations | grep -v GENERATED)

{ for animation in $animations; do
    echo -n "$animation "
    url=$(asciinema upload "gallery-animations/$animation" | sed 's_/a/_/api/asciicasts/_')
    asciinema2gif -o $here/gallery-gifs/${animation%.json}.gif "$url"
done }  > animation-locations.generated
