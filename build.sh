#!/usr/bin/env bash
# Build Vterm (debug APK). Jalankan: bash build.sh
# Butuh: JDK 17, Android SDK (ANDROID_HOME), internet (unduh dependency + bootstrap).
set -e
cd "$(dirname "$0")"

# Build langsung di Termux: pakai aapt2 milik Termux
if [ -n "$PREFIX" ] && [ -x "$PREFIX/bin/aapt2" ]; then
  if ! grep -q aapt2FromMavenOverride gradle.properties; then
    echo "android.aapt2FromMavenOverride=$PREFIX/bin/aapt2" >> gradle.properties
  fi
fi

SDK="${ANDROID_HOME:-$ANDROID_SDK_ROOT}"
if [ -n "$SDK" ]; then
  echo "sdk.dir=$SDK" > local.properties
elif [ ! -f local.properties ]; then
  echo "[!] Set ANDROID_HOME ke folder Android SDK dulu."; exit 1
fi

chmod +x gradlew
./gradlew assembleDebug

echo; echo "APK hasil build:"
find app/build/outputs/apk -name 'vterm-app_*.apk'

for D in "$HOME/storage/downloads" /sdcard/Download; do
  if [ -d "$D" ]; then
    find app/build/outputs/apk -name 'vterm-app_*.apk' -exec cp {} "$D/" \;
    echo "Disalin ke $D"; break
  fi
done
