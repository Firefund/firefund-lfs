#!/usr/bin/env bash

# install node dependencies if node_modules does not exist
if [ ! -d "./node_modules" ]; then
    npm ci
fi

npx livereload & python3 -m http.server 9000 && fg
