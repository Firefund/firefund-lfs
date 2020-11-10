#!/usr/bin/env sh

# install node dependencies if node_modules does not exist
if [ ! -d "./node_modules" ]; then
    npm ci
fi

npx livereload --debug & python3 -m http.server 9000 && fg
