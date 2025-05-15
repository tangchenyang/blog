#!/bin/bash
CURRENT_SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_DIR=$(cd "$CURRENT_SCRIPT_DIR"/.. && pwd)
HEXO_HOME=$(cd "$PROJECT_DIR"/hexo-home && pwd)

cp -r "${PROJECT_DIR}"/blogs/* "${HEXO_HOME}"/source/_posts/
cp "${PROJECT_DIR}"/_config.yml "${HEXO_HOME}"/

cd "${HEXO_HOME}" && hexo g && hexo s
