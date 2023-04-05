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
