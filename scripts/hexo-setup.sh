#!/bin/bash
CURRENT_SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_DIR="$CURRENT_SCRIPT_DIR"/..
HEXO_HOME="$PROJECT_DIR"/hexo-home

install_hexo() {
  hexo v || (echo "Hexo is not installed. Installing now..." && npm install -g hexo-cli)
  cd "$PROJECT_DIR" && hexo init hexo-home
  cd hexo-home && npm install
}

setup_web_statistics() {
   if [ "${ENABLE_WEB_STATISTICS}" = "true" ]; then
    echo "Web statistics is enabled. Setting up..."
    sed -i "s/<enable_web_statistics>/true/g" "$HEXO_HOME"/_config.fluid.yml
    sed -i "s/<leancloud_app_id>/${HEXO_LEANCLOUD_APP_ID}/g" "$HEXO_HOME"/_config.fluid.yml
    sed -i "s/<leancloud_app_key>/${HEXO_LEANCLOUD_APP_KEY}/g" "$HEXO_HOME"/_config.fluid.yml
    sed -i "s#<leancloud_app_server_url>#${HEXO_LEANCLOUD_APP_SERVER_URL}#g" "$HEXO_HOME"/_config.fluid.yml
  else
    sed -i "s/<enable_web_statistics>/false/g" "$HEXO_HOME"/_config.fluid.yml
  fi
}

setup_web_comment() {
  if [ "${ENABLE_COMMENTS}" = "true" ]; then
    echo "Web comments is enabled. Setting up..."
    sed -i "s/<enable_comments>/true/g" "$HEXO_HOME"/_config.fluid.yml
    sed -i "s/<leancloud_app_id>/${HEXO_LEANCLOUD_APP_ID}/g" "$HEXO_HOME"/_config.fluid.yml
    sed -i "s/<leancloud_app_key>/${HEXO_LEANCLOUD_APP_KEY}/g" "$HEXO_HOME"/_config.fluid.yml
  else
    sed -i "s/<enable_comments>/false/g" "$HEXO_HOME"/_config.fluid.yml
  fi
}
setup_hexo_theme() {
  cd "$HEXO_HOME" && npm install --save hexo-theme-fluid && cd - || exit
  cp "${PROJECT_DIR}"/_config.fluid.yml "$HEXO_HOME"/_config.fluid.yml

  setup_web_statistics
  setup_web_comment

}

setup_about_page() {
  echo "Setting up about page..."
  cd "${HEXO_HOME}" && hexo new page about
  cp "${PROJECT_DIR}"/_about.md "${HEXO_HOME}"/source/about/index.md
}


main() {
  install_hexo
  setup_hexo_theme
  setup_about_page
}

main


