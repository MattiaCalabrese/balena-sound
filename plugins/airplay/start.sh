#!/usr/bin/env sh

if [[ -n "$SOUND_DISABLE_AIRPLAY" ]]; then
  echo "Airplay is disabled, exiting..."
  exit 0
fi

# --- ENV VARS ---
# SOUND_DEVICE_NAME: Set the device broadcast name for AirPlay
# SOUND_DEVICE_NAME=${SOUND_DEVICE_NAME:-"balenaSound AirPlay $(echo "$BALENA_DEVICE_UUID" | cut -c -4)"}
SOUND_DEVICE_NAME=${RESIN_DEVICE_NAME_AT_INIT:-"balenaSound AirPlay $(echo "$BALENA_DEVICE_UUID" | cut -c -4)"}
AIRPLAY_OUTPUT_RATE=${AIRPLAY_OUTPUT_RATE:-"auto"}
AIRPLAY_OUTPUT_FORMAT=${AIRPLAY_OUTPUT_FORMAT:-"auto"}

echo "general = {" > /etc/shairport-sync.conf && \
echo "ignore_volume_control = \"yes\";" >> /etc/shairport-sync.conf && \
echo "};" >> /etc/shairport-sync.conf && \
echo "sessioncontrol = { };" >> /etc/shairport-sync.conf && \
echo "alsa = {" >> /etc/shairport-sync.conf && \
echo "output_rate = $AIRPLAY_OUTPUT_RATE;" >> /etc/shairport-sync.conf && \
echo "output_format = \"$AIRPLAY_OUTPUT_FORMAT\";" >> /etc/shairport-sync.conf && \
echo "};" >> /etc/shairport-sync.conf && \
echo "sndio = { };" >> /etc/shairport-sync.conf && \
echo "pa = { };" >> /etc/shairport-sync.conf && \
echo "pipe = { };" >> /etc/shairport-sync.conf && \
echo "dsp = { };" >> /etc/shairport-sync.conf && \
echo "metadata = { };" >> /etc/shairport-sync.conf && \
echo "diagnostics = { };" >> /etc/shairport-sync.conf
    
echo "Starting AirPlay plugin..."
echo "Device name: $SOUND_DEVICE_NAME"

# Start AirPlay
echo "Starting Shairport Sync"
exec shairport-sync \
  --name "$SOUND_DEVICE_NAME" \
  --output alsa \
  -- -d pulse \
  | echo "Shairport-sync started. Device is discoverable as $SOUND_DEVICE_NAME"
