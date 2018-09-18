# KeyboardMaster

[![Version](https://img.shields.io/cocoapods/v/KeyboardMaster.svg?style=flat)](http://cocoapods.org/pods/KeyboardMaster)
[![License](https://img.shields.io/cocoapods/l/KeyboardMaster.svg?style=flat)](http://cocoapods.org/pods/KeyboardMaster)
[![Platform](https://img.shields.io/cocoapods/p/KeyboardMaster.svg?style=flat)](http://cocoapods.org/pods/KeyboardMaster)

KeyboardMaster is a simple Swift extension on UIScrollView that allows you to easily and automatically manage the keyboard in iOS. Simply call `UIScrollView.registerForKeyboardEvents()` and the extension will do the rest of the work for you.

The extension converts the frame of the keyboard into the coordinate space of the scroll view, then calculates the overlap. Using the overlap rect the extension then sets `self.contentInset` accordingly.

The extension uses `NotificationCenter` to listen for keyboard events so it is important to call `UIScrollView.deregisterFromKeyboardEvents()` when you are no longer interested in monitoring keyboard activity.

You can also optionally pass the flag `automaticallyAdjustContentOffset:true` to the `.registerForKeyboardEvents()`  function to have the keyboard automatically scroll up when the keyboard shows.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

KeyboardMaster is built with Swift 4.2 and set to run on devices targeting iOS 8 and later.

## Installation

KeyboardMaster is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KeyboardMaster'
```

## Author

Lucas Best, lucas.best.5@gmail.com

## License

KeyboardMaster is available under the MIT license. See the LICENSE file for more info.
