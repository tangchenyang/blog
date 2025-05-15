#!/bin/bash
CURRENT_SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_DIR="$CURRENT_SCRIPT_DIR"

# clean hexo home
HEXO_HOME="$PROJECT_DIR"/hexo-home
if [ -d "${HEXO_HOME}" ]; then
  rm -rf "${HEXO_HOME}"
fi

# fix sed issue on MacOS
brew install gnu-sed
sed() {
  gsed "$@"
}
export -f sed

# hexo setup
export ENABLE_WEB_STATISTICS="false"
export ENABLE_COMMENTS="false"
export HEXO_LEANCLOUD_APP_ID=""
export HEXO_LEANCLOUD_APP_KEY=""
export HEXO_LEANCLOUD_APP_SERVER_URL=""

bash scripts/hexo-setup.sh

# hexo start local server
bash scripts/hexo-local-server.sh
