#!/bin/bash
CURRENT_SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_DIR=$(cd "$CURRENT_SCRIPT_DIR"/.. && pwd)
HEXO_HOME=$(cd "$PROJECT_DIR"/hexo-home && pwd)

cp "${PROJECT_DIR}"/_config.yml "${HEXO_HOME}"/
cp "${PROJECT_DIR}"/_about.md "${HEXO_HOME}"/source/about/index.md
cp -r "${PROJECT_DIR}"/blogs/* "${HEXO_HOME}"/source/_posts/


cd "${HEXO_HOME}" \
&& hexo g \
&& cp "${PROJECT_DIR}"/Weixin_QRCode.jpg "${HEXO_HOME}"/public/img/ \
&& hexo s
