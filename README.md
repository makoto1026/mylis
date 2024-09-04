# mylis

# debug build
## 開発
flutter run --dart-define=ENV=dev

## 本番
flutter run --dart-define=ENV=prod

# release build
## 開発
flutter build appbundle --dart-define=ENV=dev

## 本番
flutter build appbundle --dart-define=ENV=prod

## デバイス選択
open -a Simulator
flutter devices

## GoogleAdMobについて
本番用の広告については、本番ビルドでは表示されない（開発版は開発ビルドで表示される）

## シェアについて
開発環境では実施できないが、本番環境では実行できる