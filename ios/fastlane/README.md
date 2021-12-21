fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios signing_alpha
```
fastlane ios signing_alpha
```
Sync Alpha signing
### ios signing_beta
```
fastlane ios signing_beta
```
Sync Beta signing
### ios signing_production
```
fastlane ios signing_production
```
Sync Production signing
### ios build_alpha
```
fastlane ios build_alpha
```
Create a new Alpha build
### ios build_beta
```
fastlane ios build_beta
```
Create a new Beta build
### ios build_production
```
fastlane ios build_production
```
Create a new Production build
### ios upload_testflight_alpha
```
fastlane ios upload_testflight_alpha
```
Upload the Alpha build to the TestFlight
### ios upload_testflight_beta
```
fastlane ios upload_testflight_beta
```
Upload the Beta build to the TestFlight
### ios upload_testflight_production
```
fastlane ios upload_testflight_production
```
Upload the Production build to the TestFlight
### ios test_alpha
```
fastlane ios test_alpha
```
Run tests on Alpha
### ios test_beta
```
fastlane ios test_beta
```
Run tests on Beta
### ios test_production
```
fastlane ios test_production
```
Run tests on Production
### ios dsym_alpha
```
fastlane ios dsym_alpha
```
Sync Alpha dSYM files
### ios dsym_beta
```
fastlane ios dsym_beta
```
Sync Beta dSYM files
### ios dsym_production
```
fastlane ios dsym_production
```
Sync Production dSYM files
### ios tag
```
fastlane ios tag
```
Create and push git tag

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
