#!/bin/bash
CURRENT_SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
PROJECT_DIR=$(cd "$CURRENT_SCRIPT_DIR"/.. && pwd)
HEXO_HOME=$(cd "$PROJECT_DIR"/hexo-home && pwd)

cp -r "${PROJECT_DIR}"/blogs/* "${HEXO_HOME}"/source/_posts/
cp "${PROJECT_DIR}"/_config.yml "${HEXO_HOME}"/

sed -i "s#<git_https_url>#${GIT_HTTPS_URL}#g" "${HEXO_HOME}"/_config.yml
sed -i "s/<git_user_name>/${GIT_USER_NAME}/g" "${HEXO_HOME}"/_config.yml
sed -i "s/<git_user_email>/${GIT_USER_EMAIL}/g" "${HEXO_HOME}"/_config.yml
sed -i "s/<git_personal_access_token>/${HEXO_DEPLOY_PAT}/g" "${HEXO_HOME}"/_config.yml

cd "${HEXO_HOME}" && npm install hexo-deployer-git --save && npm run deploy

