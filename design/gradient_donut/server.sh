#!/usr/bin/env bash

# enable job control for fg: https://stackoverflow.com/a/11824420/205696
set -m

# install node dependencies if node_modules does not exist
if [ ! -d "./node_modules" ]; then
    npm ci
fi

npx livereload . --debug & python3 -m http.server 9000 && fg
