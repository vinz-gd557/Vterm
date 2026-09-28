# Vterm

Terminal emulator Android berbasis [Termux](https://github.com/termux/termux-app)
(GPLv3), dengan branding, ikon, tema, dan palet warna sendiri.
Semua command Termux (bash, pkg, apt, python, git, dll.) tetap tersedia
karena bootstrap packages Termux ikut dibundel saat build.

## Yang berubah dari Termux
- Nama app: **Vterm** (label launcher, notifikasi, laporan crash, dialog)
- Ikon adaptive + legacy baru, banner TV baru
- Tema: latar `#0B0F14`, aksen cyan, palet warna terminal bergaya Tokyo Night
- Nama file APK: `vterm-app_<varian>-debug_<abi>.apk`, versi `1.0.0`
- Package name / `applicationId` **tetap `com.termux`** (lihat catatan)

## Build lokal
```bash
bash build.sh
```
APK ada di `app/build/outputs/apk/debug/` (dan disalin ke folder Download
jika tersedia). Pilih `vterm-app_apt-android-7-debug_arm64-v8a.apk` untuk
HP arm64 modern, atau `..._universal.apk` kalau ragu.

Kebutuhan: JDK 17, Android SDK (platform 36, build-tools, NDK 29.0.14206865
sesuai `gradle.properties`), `ANDROID_HOME`, dan internet saat build pertama
(Gradle mengunduh dependency dan bootstrap Termux).

## Catatan penting: package name
Bootstrap Termux dikompilasi dengan prefix
`/data/data/com.termux/files/usr`. Mengganti package name membuat command
rusak kecuali bootstrap dibangun ulang dengan prefix baru
(lihat `termux/termux-packages`). Karena itu `com.termux` dipertahankan.
Akibatnya:
- Vterm tidak bisa terpasang berdampingan dengan Termux.
- Jika Termux yang terpasang berasal dari F-Droid/Play (tanda tangan berbeda),
  uninstall dulu sebelum install Vterm. Backup data (`~/`) dulu.
- Plugin resmi Termux (API, Boot, dst.) butuh tanda tangan yang sama,
  jadi tidak otomatis cocok dengan build ini.

## Lisensi
GPLv3, sama seperti Termux. Lihat `LICENSE.md` dan `NOTICE`.
Jika APK dibagikan ke orang lain, source-nya juga harus disediakan.
