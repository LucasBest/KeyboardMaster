#
# Be sure to run `pod lib lint KeyboardMaster.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KeyboardMaster'
  s.version          = '1.0.1'
  s.summary          = 'KeyboardMaster is a UIScollView extension intended to make it easier to manage the iOS keyboard.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KeyboardMaster is a simple Swift extension on UIScrollView that allows you to easily and automatically manage the keyboard in iOS. Simply call UIScrollView.registerForKeyboardEvents() and the extension will do the rest of the work for you.
                       DESC

  s.homepage         = 'https://github.com/LucasBest/KeyboardMaster'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas Best' => 'lucas.best.5@gmail.com' }
  s.source           = { :git => 'https://github.com/LucasBest/KeyboardMaster.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KeyboardMaster/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KeyboardMaster' => ['KeyboardMaster/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
