#!/bin/bash

# Run rathole server in the background, then run Caddy
./rathole server.toml &
caddy run --config Caddyfile --adapter caddyfile
