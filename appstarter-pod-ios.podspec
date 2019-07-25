#
# Be sure to run `pod lib lint appstarter-pod-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'appstarter-pod-ios'
  s.version          = '0.1.15'
  s.summary          = 'Utility files to get an app up and running'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Utility files containing code to get an app up and running
                       DESC

  s.homepage         = 'https://github.com/gearnshaw/appstarter-pod-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gearnshaw' => 'g_earnshaw@hotmail.com' }
  s.source           = { :git => 'https://github.com/gearnshaw/appstarter-pod-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'appstarter-pod-ios/Classes/**/*'
  s.resources = 'appstarter-pod-ios/Resources/**/*'

  # s.resource_bundles = {
  #   'appstarter-pod-ios' => ['appstarter-pod-ios/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'XCGLogger', '~> 7.0'
  s.dependency 'MockBalm'
  s.dependency 'SwiftLint'
end
