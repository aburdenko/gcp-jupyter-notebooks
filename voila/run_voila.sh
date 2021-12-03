#!/bin/bash
LOW_BOUND=49152
RANGE=16384
while true; do
    PORT=$[$LOW_BOUND + ($RANDOM % $RANGE)]
    (echo "" >/dev/tcp/127.0.0.1/${CANDIDATE}) >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo $PORT
        break
    fi
done
fuser -k -TERM -n tcp $PORT
/content/notebooks/bin/voila --port $PORT --no-browser --debug --strip_sources=True /content/notebooks/voila/voila_earth_demo.ipynb & npx localtunnel --port $PORT