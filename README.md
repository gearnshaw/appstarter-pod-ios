# appstarter-pod-ios

[![CI Status](https://img.shields.io/travis/gllittler/appstarter-pod-ios.svg?style=flat)](https://travis-ci.org/gllittler/appstarter-pod-ios)
[![Version](https://img.shields.io/cocoapods/v/appstarter-pod-ios.svg?style=flat)](https://cocoapods.org/pods/appstarter-pod-ios)
[![License](https://img.shields.io/cocoapods/l/appstarter-pod-ios.svg?style=flat)](https://cocoapods.org/pods/appstarter-pod-ios)
[![Platform](https://img.shields.io/cocoapods/p/appstarter-pod-ios.svg?style=flat)](https://cocoapods.org/pods/appstarter-pod-ios)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

appstarter-pod-ios is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'appstarter-pod-ios'
```

## Setting up a new project with appstarter-pod-ios
1. Create a new project in Xcode
1. Set up cocoapods and install appstarter-pod-ios as described above
1. Copy `Gemfile` from `/appstarter-pod-ios/appstarter-pod-ios/Resources/Bundler`. This includes the `cocopods` and `fastlane` gems and will allow `bundler` be used. Use the command: `cp Pods/appstarter-pod-ios/appstarter-pod-ios/Resources/Bundler/Gemfile Gemfile`
1. Run `bundle install` to install dependencies from the gemfile
1. Set up fastlane
1. Copy the `Fastfile` from `/appstarter-pod-ios/appstarter-pod-ios/Resources/Fastlane` to the `fastlane` directory of the project
1. Run `bundle exec fastlane copyResources` to copy over other required Resources
1. open `/Fastlane/.env.default` (copied in the above step) and edit variables to apply to this project
1. Add a SwiftLint build phase to the project
1. Sourcery set up
  1. Edit `.sourcery.yml` to set up for the current project
  1. Edit `SourceryTemplates/Test/LocalImports.stencil` to set up for the current project
  1. Add a Sourcery build phase to the project
1. Set up automatic versioning. Follow the steps here: https://developer.apple.com/library/content/qa/qa1827/_index.html
1. Set up certificates and provisioning profiles
  1. Ensure source control is clean
  1. Edit the `Fastfile` to turn off the `readonly` flag in the `:certificates` lane (see the comments in the file to explain which line to comment in)
  1. Run `bundle exec fastlane certificates`
  1. Reset the changes that were made to the fastlane script
1. Run `bundle exec fastlane printVariables` and check against the Xcode project that everything is set up correctly

## Updating to the latest version of appstarter-pod-ios
1. Update the pod: `bundle exec pod update appstarter-pod-ios`
1. Ensure everything is committed (or staged) in source control
1. Update to the latest versions of scripts by running `bundle exec fastlane copyResources`
1. *Check the changes in source control*. Some files, such as `.env.default` will overwrite the local versions, so you'll need to reset any files (or individual lines) that you don't want.

## Author

gllittler, g_earnshaw@hotmail.com

## License

appstarter-pod-ios is available under the MIT license. See the LICENSE file for more info.
