#!/usr/bin/env bash

if [[ -n "$SOUND_DISABLE_BLUETOOTH" ]]; then
  echo "Bluetooth is disabled, exiting..."
  exit 0
fi

BLUETOOTH_DEVICE_NAME=${RESIN_DEVICE_NAME_AT_INIT:-"balenaSound Bluetooth $(echo "$BALENA_DEVICE_UUID" | cut -c -4)"}

exec /usr/src/bluetooth-agent
