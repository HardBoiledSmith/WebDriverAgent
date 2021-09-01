#!/bin/bash

UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="${HOMEBREW_PREFIX}/bin:$PATH"
else
  HOMEBREW_PREFIX="/usr/local"
  export PATH="${HOMEBREW_PREFIX}/bin:$PATH"
fi

echo 'Device:'
idevice_id -l

read -p 'Pick device num (1~N): ' -r DEVICE_NUM
echo "${DEVICE_NUM}"

UDID=$(idevice_id -l | sed -n "${DEVICE_NUM}p")
echo "Using ${UDID}"

xcodebuild -project WebDriverAgent.xcodeproj -scheme WebDriverAgentRunner -destination "id=$UDID" -allowProvisioningUpdates test
