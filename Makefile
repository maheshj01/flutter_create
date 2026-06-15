# NOTE: THESE commands are good during development and QA releases.
# DO NOT USE THIS FOR MAKING A PRODUCTION RELEASE
current_dir := $(shell 'pwd')
# Set the path to your Flutter SDK
FLUTTER := $(shell which flutter)
DART := $(shell which dart)

FLUTTER_VERSION := 3.38.5

start-devtools:
	$(FLUTTER) pub global run devtools

format:
	$(DART) format --line-length 100 .

format-check:
	$(FLUTTER) format --line-length 100 --set-exit-if-changed .

lint:
	$(FLUTTER) analyze

format-lint: format lint

run:
	$(FLUTTER) run $(if $(RELEASE),--release)
# make update_version VERSION=4.0.5+360666

update_version:
	@if [ -z "$(VERSION)" ]; then \
		echo "Usage: make update_version VERSION=x.y.z+build"; \
		exit 1; \
	fi
	@echo "Updating version to $(VERSION)..."
	sed -i '' "s/^version: .*/version: $(VERSION)/" pubspec.yaml
	sed -i '' "s|static const String appVersion = '.*';|static const String appVersion = '$(VERSION)';|" lib/utilities/constants.dart
	@echo "Version updated successfully!"
	@echo "Updated files:"
	@echo "  - pubspec.yaml"
	@echo "  - lib/utilities/constants.dart"

# Auto-increment build number
increment_build:
	@echo "Auto-incrementing build number..."
	$(eval CURRENT_VERSION := $(shell grep '^version:' pubspec.yaml | sed 's/version: //'))
	$(eval VERSION_BASE := $(shell echo $(CURRENT_VERSION) | cut -d'+' -f1))
	$(eval BUILD_NUMBER := $(shell echo $(CURRENT_VERSION) | cut -d'+' -f2))
	$(eval NEW_BUILD_NUMBER := $(shell echo $$(($(BUILD_NUMBER) + 1))))
	$(eval NEW_VERSION := $(VERSION_BASE)+$(NEW_BUILD_NUMBER))
	@echo "Current version: $(CURRENT_VERSION)"
	@echo "New version: $(NEW_VERSION)"
	@sed -i '' "s/^version: .*/version: $(NEW_VERSION)/" pubspec.yaml
	@sed -i '' "s|static const String appVersion = '.*';|static const String appVersion = '$(NEW_VERSION)';|" lib/utilities/constants.dart
	@echo "Build number incremented successfully!"
	@echo "Updated files:"
	@echo "  - pubspec.yaml"
	@echo "  - lib/utilities/constants.dart"

upload_dsym_ios:
	ios/Pods/FirebaseCrashlytics/upload-symbols -gsp ios/Runner/GoogleService-Info.plist -p ios build/ios/archive/Runner.xcarchive/dSYMs

# make release VERSION=3.36.8+360636
# Or simply: `make release` (will auto-increment build number)
release: $(if $(VERSION),update_version,increment_build) release_ios release_android upload_dsym_ios

release_ios: update_submodules
	$(FLUTTER) build ipa \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT)

release_android: update_submodules generate
	$(FLUTTER) build appbundle \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT)

release_apk: update_submodules
	$(FLUTTER) build apk \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT) \
		$(if $(split),--split-per-abi,)

# Create a release for shorebird
shorebird_release_android: update_submodules
	shorebird release android \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT) \
		--flutter-version=$(FLUTTER_VERSION)

shorebird_release_ios: update_submodules
	shorebird release ios \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT) \
		--flutter-version=$(FLUTTER_VERSION)

shorebird_release: shorebird_release_ios shorebird_release_android

# Caution when using the patch command, it will patch the current release with the new changes. Ensure you have the flags set correctly.
shorebird_patch_android: update_submodules
	shorebird patch android \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT) \

shorebird_patch_ios: update_submodules
	shorebird patch ios \
		--dart-define IV3_SHOW_ENVIRONMENT_SWITCHER=$(IV3_SHOW_ENVIRONMENT_SWITCHER) \
		--dart-define IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER=$(IV3_INCLUDE_LOCAL_OPTIONS_IN_SWITCHER) \
		--dart-define IV3_HIDE_CAPTCHA_SCREENS_AND_TC=$(IV3_HIDE_CAPTCHA_SCREENS_AND_TC) \
		--dart-define IV3_DEFAULT_ENVIRONMENT=$(IV3_DEFAULT_ENVIRONMENT) \

generate:
    # generate the hive adapters
	dart run build_runner build --delete-conflicting-outputs
    # run make format after generating the adapters
	make format

clean: clean_ios clean_android format

clean_ios:
	$(FLUTTER) clean && rm -rf ios/Podfile.lock && rm -rf Pods && rm -rf ios/Runner.xcarchive && $(FLUTTER) pub get && cd ios && pod install && cd ..

clean_android:
	rm -rf android/unityLibrary/build && $(FLUTTER) clean && rm -rf android/app/build && $(FLUTTER) pub get && cd android && ./gradlew clean && cd ..

generate_env:
	dart run build_runner build --delete-conflicting-outputs

rsa_keys:
	ssh-keygen -t rsa -b 4096 -m PEM -f jwtRS256.key -N ''
	openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub

	mkdir -p deploy/local/signing_keys
	mv jwtRS256.* deploy/local/signing_keys

localenv: rsa_keys

.PHONY: start-emu start-devtools generate emulator rsa_keys localenv update_version increment_build upload_dsym_ios
