# Matee iOS DevStack

## Dependencies

- All code dependencies and tools are managed
  via [Swift Package Manager](https://swift.org/package-manager/)
- You can use the `scripts/setup.sh` for quick setup of all required tools
- There is also `scripts/rename.sh` for quick renaming from DevStack to YourProject

## Kotlin Multiplatform

- The most of the code is shared with Android via Kotlin Multiplatform
- You will need [JDK 17](https://www.azul.com/downloads) to build the project
- There is `scripts/build-kmp.sh` that produces `DomainLayer/KMPShared.xcframework`

## Architecture

- There are some classes not shared with Android but instead implemented in Swift
- Whole application is separated into three layers according to the Clean Architecture principles
- Dependencies between layers: `PresentationLayer -> DomainLayer <- DataLayer`
- DomainLayer reflects whole business logic of the application via DomainModels and UseCases
- DataLayer provides required data via Repositories and Providers from database / network / etc.
- Network communication is based on URLSession and native Decodable is used for mapping from JSON
- Providers/Repositories/UseCases are registered/resolved
  via [Factory](https://github.com/hmlongco/Factory)

## PresentationLayer

### SwiftUI + MVI + async/await

- PresentationLayer is represented by ViewModels + Views and FlowControllers
- ViewModel has its state and intents which are then used in a relevant SwiftUI View
- Asynchronous work is represented via native async/await
- Example: `PresentationLayer/Sample`

### SwiftUI + shared view models

- Views are written in SwiftUI, view models are written in Kotlin code and shared for both
  platforms, for ease of use in iOS see `.bindViewModel` extension
- Example: `PresentationLayer/SampleSharedViewModels`

### Shared Compose Multiplatform Views and shared view models

- In Swift each screen needs a FlowController and ViewControllerDelegate
- You can also implement SwiftUI Screen with the ViewController inside to have access to View
  extensions such as `toast` or `navigationTitle`
- in `iosMain` in Kotlin code there needs to be a `ComposeUIViewController` for each screen with
  a `ComposeUIViewControllerDelegate` inside which you should call `.clear()` on the shared view
  model to ensure the correct cancellation of running coroutines when the View is destroyed
- Example: `PresentationLayer/SampleSharedViewModels`

## Style Guide

- [Swift Style Guide](https://github.com/raywenderlich/swift-style-guide)
- Swiftlint is enabled for the whole codebase, you can find its configuration inside
  the `.swiftlint.yml`
- Unfinished or broken code should be marked with `#warning("TODO:")` or `#warning("FIXME:")`
- Identifiers for assets, colors and localized strings are generated
  with [SwiftGen](https://github.com/SwiftGen/SwiftGen)

## Localization

### Twine

- All strings in the application are localized and shared with the Android team
  via [Twine](https://github.com/scelis/twine)
- Strings are stored in the `twine/strings.txt` file
- TwinePlugin then generates appropriate `Localizable.strings` files from the
  mentioned `strings.txt` file
- When modifying `strings.txt` it is required to comply with the specified syntax and to pull/push
  all the changes frequently

### Moko

- Error messages are shared via [Moko Resources](https://github.com/icerockdev/moko-resources), so
  that we can use the strings in the shared code and avoid duplicities when converting errors to
  string messages
- Error strings are stored in the `twine/errors.txt` file
- Script `generate-error-messages.sh` calls needed gradle tasks (`generateErrorsTwine`
  and `generateMRCommonMain`) to generate `MR` class and script `copy-moko-resources.sh` copies the
  resources to the iOS project

## Debug

- All important information should be logged using the system `Logger`
- All network requests going through the `SystemNetworkProvider` are logged in debug builds
- [Proxyman](https://proxyman.io) for HTTP request/response debugging is enabled for alpha and beta
  builds

## Build + Release

- CI/CD process is based on [GitHub Actions](https://github.com/features/actions)
  and [Fastlane](https://fastlane.tools/)
- Configurations for GitHub Actions are in the `.github/workflows` folder
- Configuration for Fastlane is in the `FastlaneRunner` package
- Version number is taken from the Xcode project (it should
  respect [Semantic Versioning](https://semver.org))
- Build number is generated on the CI server, the value set in the Xcode project is ignored
- For every merge to develop branch, a new alpha build is created and uploaded to the TestFlight for
  internal testers
- Comment with version and build numbers is automatically added to the relevant JIRA issue (branch
  or commit must contain an issue key)
- Release builds must be triggered manually on the GitHub website
- Release builds for all environments are then produced and uploaded to the TestFlight for both
  internal and external testers
- After successful release build, a git tag with version and build numbers is created and pushed to
  the git

## Tests

- All newly created ViewModels / UseCases / Repositories should have at least a basic set of tests
- [Spyable](https://github.com/Matejkob/swift-spyable) is used for automatic mock generation
