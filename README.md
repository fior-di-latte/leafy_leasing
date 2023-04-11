<img src="./assets/logo.png" width=180 height="180"/>

# Leafy Leasing  🪴

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

This project was started using the [Very Good CLI][very_good_cli_link] 🤖.

_"A companion app for PaaS (_Plants as a Service_) companies."_

### Under the hood
* 💅  Design System: Material 3 with a green seed color, incl. dark  and light mode
* 🏄‍♂ ️State Management: `riverpod`: All AsyncStates _(loading, error, data)_ handled by UI
* ➡️ Monodirectional Data Flow: Data Service -> Repository -> StateNotifierProvider -> UI
* 🪝 Local State Management: `flutter_hooks`
* 🐝 Data Persistence: `hive`
* 🧭 Navigation: `auto_route`
* 🗣️ Internationalization: `flutter_localizations`
* 📄 Declarative Logging: `loggy` with listeners on providers (BL), widget states and route changes.

Mock backend via local NoSQL database (`hive`), initialized with json data & made pseudo async with a short network delay of 300 milliseconds.

Developed using Flutter 3.7.8 and Dart 2.19.5, tested **only** on Android (API 31, Pixel 4a Emulator).
_No tests, no actively used flavors._
### Todos
* Tests
* Flavors for CI/CD
* Proper abstraction of repositories (s.t. backend is easily _'pluggable'_)
* Persistance of `ThemeMode`and `Locale` over app restarts with `hive`
* Change App Logo to Leafy Leasing Logo.

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:
### Important: Use build_runner before `flutter run`, otherwise the code won't complile.
`flutter pub run build_runner build --delete-conflicting-outputs
`
```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Leafy Leasing should work on iOS, Android, Web, and Windows._


**All those flavors are currently pointing to the same bootstrap function.** 

---
## Commit Keys 🔑

* **FT**  New Feature
* **REF**  Refactoring
* **ENH**  Enhancement (w/o UI)
* **UI**   User Interface Enhancement
* **BFX**  Bugfix
* **DAT**  Data (configs, dummy data)
* **IMG**  Images / Animation
* **LOC**  Localization / Internationalization
* **DEP**  Deployment
* **ICM**  Big new stuff (e.g. new backend integration) (non-features)

---
## Running Tests 🧪 (Currently not integrated ❌) 

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:leafy_leasing/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_de.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_de.arb`

```arb
{
    "@@locale": "de",
    "counterAppBarTitle": "Zähler",
    "@counterAppBarTitle": {
        "description": "Text, der in der AppBar der Zählerseite angezeigt wird"
    }
}
```
--- 
## App Logo 🪴
The logo is designed with some help from [BlueWillow AI](https://www.bluewillow.ai/) (=sth. like Midjourney).
* To initialize a new splash screen, use
```flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml```.


[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
