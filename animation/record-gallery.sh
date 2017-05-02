#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
cd "$here"

"$here/animate.sh" "Zshnip: Expanding a snippet" gallery-expand-actions.sh gallery-animations/gallery-expand.json

sleep 1

"$here/animate.sh" "Zshnip: Defining a new snippet" gallery-define-actions.sh gallery-animations/gallery-define.json


sleep 1

"$here/animate.sh" "Zshnip: Editing an existing snippet" gallery-edit-actions.sh gallery-animations/gallery-edit.json

sleep 1

"$here/animate.sh" "Zshnip: Defining multiple snippets at the same time" gallery-nest-actions.sh gallery-animations/gallery-nest.json
@
