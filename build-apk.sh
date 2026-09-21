#!/usr/bin/env bash
# Membangun APK debug GilangMOBA. Butuh: Node 18+, JDK 17, Android SDK (ANDROID_HOME terpasang).
set -e
npm install @capacitor/core @capacitor/cli @capacitor/android
[ -d android ] || npx cap add android

MAN=android/app/src/main/AndroidManifest.xml
STY=android/app/src/main/res/values/styles.xml
# Paksa landscape
grep -q 'screenOrientation' "$MAN" || sed -i 's#<activity #<activity android:screenOrientation="sensorLandscape" #' "$MAN"
# Layar penuh
grep -q 'windowFullscreen' "$STY" || sed -i 's#\(<style name="AppTheme.NoActionBar"[^>]*>\)#\1\n        <item name="android:windowFullscreen">true</item>#' "$STY"

npx cap sync android
( cd android && ./gradlew assembleDebug )
echo
echo "Selesai. APK ada di: android/app/build/outputs/apk/debug/app-debug.apk"
