#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
cd "$here"

"$here/animate.sh" "Zshnip: Expanding a snippet" gallery-expand-actions.sh gallery-animations/gallery-1-expand.json
"$here/animate.sh" "Zshnip: Defining a new snippet" gallery-define-actions.sh gallery-animations/gallery-1-define.json
"$here/animate.sh" "Zshnip: Editing an existing snippet" gallery-edit-actions.sh gallery-animations/gallery-1-edit.json
"$here/animate.sh" "Zshnip: Defining multiple snippets at the same time" gallery-nest-actions.sh gallery-animations/gallery-1-nest.json
@