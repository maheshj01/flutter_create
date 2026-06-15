# Flutter Template

A production-ready Flutter starter template designed to help you start building your application immediately.

The default Flutter counter app is excellent for learning Flutter, but most real-world applications require a common set of configurations and project structure before development can begin. Setting up folders, networking, localization, model generation, linting, and other boilerplate tasks for every new project quickly becomes repetitive.

This template aims to eliminate that repetitive setup work by providing a solid foundation that can be used as a starting point for most Flutter applications.

## Features

- Organized project structure
- Localization support
- Networking layer setup
- JSON serialization support
- Common `.gitignore` configuration
- Environment ready for scaling
- Example model generation setup
- Production-friendly architecture

While every project has different requirements, this template covers the essentials that are commonly needed across Flutter applications.

Feel free to fork this repository and customize it to fit your team's workflow and coding standards.

If this template saves you even 15 minutes when starting a new project, it has achieved its purpose.

---

## Getting Started

Clone or fork the repository and install dependencies:

```bash
flutter pub get
```

Generate model files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous code generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

## Post Setup Checklist

### 1. Update Application Name

#### Android

Open:

```text
android/app/src/main/AndroidManifest.xml
```

Update:

```xml
android:label="Your App Name"
```

#### iOS

Open:

```text
ios/Runner/Info.plist
```

Update:

```xml
<key>CFBundleName</key>
<string>Your App Name</string>
```

If you need additional help, refer to:

[https://stackoverflow.com/questions/49353199/how-can-i-change-the-app-display-name-build-with-flutter](https://stackoverflow.com/questions/49353199/how-can-i-change-the-app-display-name-build-with-flutter)

---

### 2. Update Package Name

The template uses a placeholder package name:

```text
com.example.flutter_template
```

Replace it with your own package name throughout the project.

Examples:

```text
com.company.myapp
io.mycompany.product
```

You can use your IDE's search-and-replace feature or a package renaming tool.

---

### 3. Configure Localization

Localization is enabled by default.

If your application does not require localization:

- Remove the `lib/localization` directory
- Remove localization-related dependencies from `pubspec.yaml`

```yaml
flutter_localizations:
```

And any other localization packages you are not using.

---

### 4. Generate JSON Models

This template includes an example model located at:

```text
lib/models/user_model.dart
```

After modifying or creating models, regenerate the files using:

```bash
make generate
```

For automatic generation while developing:

```bash
make watch-generate
```

---

### 5. Update Project Metadata

Open `pubspec.yaml` and update:

- name
- description
- version
- homepage
- repository
- issue_tracker

Example:

```yaml
name: my_app
description: My awesome Flutter application
version: 1.0.0+1
```

---

### 6. Configure App Assets

Update the following as needed:

- App icon
- Splash screen
- Fonts
- Theme colors
- Environment configuration

---

## Project Structure

```text
assets/
  - images/
  - fonts/
lib/
├── localization/
├── models/
├── network/
├── screens/
├── widgets/
├── utils/
└── main.dart
```

Modify the structure as needed to fit your architecture and development style.

---

## Contributing

Suggestions, improvements, and bug reports are always welcome.

If you find an issue or have an idea that could make this template better:

1. Open an issue
2. Create a pull request
3. Share feedback

Over time, community contributions help keep this template useful and up to date for everyone.

## License

Feel free to use, modify, and distribute this template in your own projects.

A few additional modern improvements I'd consider for the repo itself:

### TODO:

- Add `analysis_options.yaml`
- Add flavors (`dev`, `staging`, `prod`)
- Add `.env` support with `flutter_dotenv`
- Add `Melos` support if you plan to scale to packages
- Add GitHub Actions for CI
- Add `Riverpod` or your preferred state management solution
- Add crash reporting and analytics examples
- Add a one-command setup script (`make setup` or `./scripts/bootstrap.sh`)
