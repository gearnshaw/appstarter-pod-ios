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
1. Copy `Gemfile` from `/appstarter-pod-ios/appstarter-pod-ios/Resources/Bundler`. This includes the `cocopods` and `fastlane` gems and will allow `bundler` be used.
1. Set up fastlane
1. Copy the `Fastfile` from `/appstarter-pod-ios/appstarter-pod-ios/Resources/Fastlane` to the `fastlane` directory of the project
1. Run `bundle exec fastlane copyResources` to copy over other required Resources
1. open ``/Fastlane/.env.default` (copied in the above step) and edit variables to apply to this project
1. Add a SwiftLint build phase to the project
1. Add a Sourcery build phase to the project

## Author

gllittler, g_earnshaw@hotmail.com

## License

appstarter-pod-ios is available under the MIT license. See the LICENSE file for more info.
