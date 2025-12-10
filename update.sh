#!/bin/bash -x

APP="homepage"
LOCAL_IP=$(hostname -I | awk '{print $1}')
RELEASE=$(curl -fsSL https://api.github.com/repos/gethomepage/homepage/releases/latest | grep "tag_name" | awk '{print substr($2, 3, lengt>

apt update && apt upgrade -y

npm install -g pnpm

if [[ ! -d /opt/${APP} ]]; then
  msg_error "No ${APP} installation found!"
  exit
fi
if [[ "${RELEASE}" != "$(cat /opt/${APP}_version.txt)" ]] || [[ ! -f /opt/${APP}_version.txt ]]; then
  msg_info "Updating ${APP} to v${RELEASE} (Patience)"
  systemctl stop ${APP}
  curl -fsSL "https://github.com/gethomepage/homepage/archive/refs/tags/v${RELEASE}.tar.gz" -o $(basename "https://github.com/gethomepage/>
  tar -xzf v${RELEASE}.tar.gz
  rm -rf v${RELEASE}.tar.gz
  cp -r homepage-${RELEASE}/* /opt/${APP}/
  rm -rf homepage-${RELEASE}
  cd /opt/${APP}
  $STD pnpm install
  $STD pnpm update --no-save caniuse-lite
  $STD pnpm build
  if [[ ! -f /opt/${APP}/.env ]]; then
    echo "HOMEPAGE_ALLOWED_HOSTS=localhost:3000,${LOCAL_IP}:3000,homepage.home.jnbolsen.com:3000" >/opt/${APP}/.env
  fi
  systemctl start ${APP}
  echo "${RELEASE}" >/opt/${APP}_version.txt
  msg_ok "Updated successfully!"
else
  echo "No update required, ${APP} is already at v${RELEASE}"
fi
exit
