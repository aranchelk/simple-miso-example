set -e
stack build
cp $(dirname $(stack path --local-hpc-root))/bin/*/all.js ./output/
cp data/index.html ./output/
(cd output && python -m SimpleHTTPServer 8000 output/) &
open http://localhost:8000/
wait
