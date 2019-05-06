Pod::Spec.new do |s|
  s.name             = 'KeyboardMaster'
  s.version          = '1.2.0'
  s.summary          = 'KeyboardMaster is a UIScollView extension intended to make it easier to manage the iOS keyboard.'

  s.description      = <<-DESC
KeyboardMaster is a simple Swift extension on UIScrollView that allows you to easily and automatically manage the keyboard in iOS. Simply call UIScrollView.registerForKeyboardEvents() and the extension will do the rest of the work for you.
                       DESC

  s.homepage         = 'https://github.com/LucasBest/KeyboardMaster'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas Best' => 'lucas.best.5@gmail.com' }
  s.source           = { :git => 'https://github.com/LucasBest/KeyboardMaster.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thereallu5'

  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = 'KeyboardMaster/Classes/**/*'

  s.frameworks = 'UIKit'
end
