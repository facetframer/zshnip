#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

youtube-upload presentation.mp4 --title 'Introduction to Zshnip: define-as-you-go zsh snippets' --credentials-file youtube-credentials.json --description 'Zshnip is a zsh snippet library (See http://facetframer.com/zshnip)' --client-secrets youtube-secrets.json
