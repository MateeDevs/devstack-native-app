# Matee iOS DevStack
- Historical development prior monorepo can be seen in the [devstack-ios-app](https://github.com/MateeDevs/devstack-ios-app) repo

## Documents
- **API Doc:** [Postmanerator](https://devstack-server-production.up.railway.app/apidoc.html)
- **Specification:** FIXME
- **Graphics:** FIXME
- **Assets**: FIXME

## ALPHA

### Configuration
- **BundleID:** cz.matee.devstack.alpha
- **API endpoint:** FIXME

### Test accounts
FIXME

## BETA

### Configuration
- **BundleID:** cz.matee.devstack.beta
- **API endpoint:** FIXME

### Test accounts
FIXME

## PRODUCTION

### Configuration
- **BundleID:** cz.matee.devstack
- **API endpoint:** FIXME

### Test accounts
FIXME

## Dependencies
- All code dependencies are managed via [Swift Package Manager](https://swift.org/package-manager/)
- All tools (SwiftGen, SwiftLint, etc.) are managed via [Mint](https://github.com/yonaskolb/Mint)
- You can use the `scripts/setup.sh` for quick setup of all required tools
- There is also `scripts/rename.sh` for quick renaming from DevStack to YourProject

## Kotlin Multiplatform
- Part of the application is based on Kotlin Multiplatform
- You will need [JDK 11](https://www.azul.com/downloads) to build the project
- There is `scripts/build-kmp.sh` that is producing `DomainLayer/DevstackKmpShared.xcframework`
- It is executed automatically with every build as a part of the build's Pre-actions

## Architecture
- Whole application is separated into three layers according to the Clean Architecture principles
- Dependencies between layers: `PresentationLayer -> DomainLayer <- DataLayer`
- DomainLayer reflects whole business logic of the application via DomainModels and UseCases
- DataLayer provides required data via Repositories and Providers from database / network / etc.
- Network communication is based on URLSession and native Decodable is used for mapping from JSON
- Database models are represented via [Realm](https://github.com/realm/realm-cocoa) object models
- Providers/Repositories/UseCases are injected via [Resolver](https://github.com/hmlongco/Resolver)

## PresentationLayer (SwiftUI + MVI + async/await)
- PresentationLayer is represented by ViewModels + Views and FlowControllers
- ViewModel has its state and intents which are then used in a relevant SwiftUI View
- Asynchronous work is represented via native async/await

## Style Guide
- [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
- Swiftlint is enabled for the whole codebase, you can find its configuration inside the `.swiftlint.yml`
- Unfinished or broken code should be marked with `#warning("TODO:")` or `#warning("FIXME:")`
- Identifiers for assets, colors and localized strings are generated with [SwiftGen](https://github.com/SwiftGen/SwiftGen)

## Localization
- All strings in the application are localized and shared with the Android team via [Twine](https://github.com/scelis/twine)
- Strings are stored in the `twine/strings.txt` file
- The build phase script then generates appropriate `Localizable.strings` files from the mentioned `strings.txt` file
- When modifying `strings.txt` it is required to comply with the specified syntax and to pull/push all the changes frequently

## Push Notifications
- Push Notifications are sent via [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)
- All received notifications are handled inside the `HandlePushNotificationUseCase`
- Notifications can be easily tested with scripts from the [ios-push-tester](https://github.com/MateeDevs/ios-push-tester) repository

## Debug
- All important information should be logged using the system `Logger`
- All network requests going through the `SystemNetworkProvider` are logged in debug builds
- [Proxyman](https://proxyman.io) for HTTP request/response debugging is enabled for alpha and beta builds

## Build + Release
- CI/CD process is based on [GitHub Actions](https://github.com/features/actions) and [Fastlane](https://fastlane.tools/)
- Configurations for GitHub Actions are in the `.github/workflows` folder
- Configuration for Fastlane is in the `fastlane/Fastfile` file
- Version number is taken from the Xcode project (it should respect [Semantic Versioning](https://semver.org))
- Build number is generated on the CI server, the value set in the Xcode project is ignored
- For every merge to develop branch, a new alpha build is created and uploaded to the TestFlight for internal testers
- Comment with version and build numbers is automatically added to the relevant JIRA issue (branch or commit must contain an issue key) 
- Release builds must be triggered manually on the GitHub website
- Release builds for all environments are then produced and uploaded to the TestFlight for both internal and external testers
- After successful release build, a git tag with version and build numbers is created and pushed to the git

## Tests
- All newly created ViewModels / UseCases / Repositories should have at least a basic set of tests
- [Sourcery](https://github.com/krzysztofzablocki/Sourcery) is used for automatic mock generation

## TODO
- Replace Mint with SPM Extensible Build Tools when all tools are ready
