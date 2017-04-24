#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"

"$here/animate.sh" "Zshnip snippet tool" animation-actions.sh presentation.json
