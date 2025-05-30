#!/bin/bash
CURRENT_SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_DIR="$CURRENT_SCRIPT_DIR"

# clean hexo home
HEXO_HOME="$PROJECT_DIR"/hexo-home
if [ "$1" == "-c" ]; then
  rm -rf "${HEXO_HOME}"
  echo "****** Cleaned Hexo home..."
fi

# fix sed issue on MacOS
echo "****** Fixing sed issue on MacOS..."
which gsed > /dev/null || ( echo "****** Installing gnu-sed..." && brew install gnu-sed )
sed() {
  gsed "$@"
}
export -f sed

# hexo setup
if [ ! -d "${HEXO_HOME}" ]; then
  echo "****** Setting up Hexo home..."

  export ENABLE_WEB_STATISTICS="false"
  export ENABLE_COMMENTS="false"
  export HEXO_LEANCLOUD_APP_ID=""
  export HEXO_LEANCLOUD_APP_KEY=""
  export HEXO_LEANCLOUD_APP_SERVER_URL=""

  bash scripts/hexo-setup.sh
fi

# hexo start local server
echo "****** Starting local server..."
bash scripts/hexo-local-server.sh
