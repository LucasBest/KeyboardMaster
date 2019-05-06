//
//  UIScrollView+Keyboard.swift
//  KeyboardMaster
//
//  Created by Lucas Best on 12/6/17.
//

import UIKit

public extension UIScrollView {
    private struct ScrollViewMetadata {
        static var contentInsetBeforeKeyboard = [UIScrollView: UIEdgeInsets]()
        static var keyboardUpForScrollView = [UIScrollView: Bool]()
        static var automaticallyAdjustContentOffset = [UIScrollView: Bool]()
        static var keyboardObservers = [UIScrollView: (showObserver: Any, hideObserver: Any)]()
    }

    func registerForKeyboardEvents(automaticallyAdjustContentOffset: Bool =  false) {
        self.deregisterFromKeyboardEvents()

        ScrollViewMetadata.automaticallyAdjustContentOffset[self] = automaticallyAdjustContentOffset

        let showObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { (notification) in
            self.updateKeyboardFrame(from: notification, keyboardGoingUp: true)
            ScrollViewMetadata.keyboardUpForScrollView[self] = true
        }

        let hideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { (notification) in
            self.updateKeyboardFrame(from: notification, keyboardGoingUp: false)
            ScrollViewMetadata.keyboardUpForScrollView[self] = false
        }

        ScrollViewMetadata.keyboardObservers[self] = (showObserver:showObserver, hideObserver:hideObserver)
    }

    func deregisterFromKeyboardEvents() {
        self.removeObservers()

        ScrollViewMetadata.contentInsetBeforeKeyboard.removeValue(forKey: self)
        ScrollViewMetadata.keyboardUpForScrollView.removeValue(forKey: self)
        ScrollViewMetadata.automaticallyAdjustContentOffset.removeValue(forKey: self)
        ScrollViewMetadata.keyboardObservers.removeValue(forKey: self)
    }

    private func updateKeyboardFrame(from notification: Notification, keyboardGoingUp: Bool) {
        let keyboardUp = ScrollViewMetadata.keyboardUpForScrollView[self] ?? false

        if !keyboardUp && keyboardGoingUp {
            ScrollViewMetadata.contentInsetBeforeKeyboard = [self: self.contentInset]
        }

        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let convertedKeyboardFrame = self.superview?.convert(keyboardFrame, from: nil) ?? keyboardFrame

            let intersectionRect = self.frame.intersection(convertedKeyboardFrame)

            var newContentInset = self.contentInset

            var newContentInsetBottom = self.frame.origin.y + self.frame.size.height - intersectionRect.origin.y

            if #available(iOS 11, *) {
                if self.adjustedContentInset.bottom != self.contentInset.bottom {
                    newContentInsetBottom -= self.safeAreaInsets.bottom
                }
            }

            if newContentInsetBottom > 0 {
                newContentInset.bottom = newContentInsetBottom
            }
            else {
                newContentInset.bottom = ScrollViewMetadata.contentInsetBeforeKeyboard[self]?.bottom ?? 0.0
            }

            self.contentInset = newContentInset
            self.scrollIndicatorInsets = newContentInset

            if ScrollViewMetadata.automaticallyAdjustContentOffset[self] ?? false && keyboardGoingUp {
                let scrolledToBottom = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom

                let potentialNewContentOffset = self.contentOffset.y + newContentInsetBottom

                let newScrollPosition = CGFloat.minimum(potentialNewContentOffset, scrolledToBottom)

                if self.yOffsetWouldScrollUp(yOffset: newScrollPosition) {
                    var contentOffset = self.contentOffset
                    contentOffset.y = newScrollPosition

                    self.contentOffset = contentOffset
                }
            }
        }
    }

    private func yOffsetWouldScrollUp(yOffset: CGFloat) -> Bool {
        return yOffset >= self.contentOffset.y
    }

    private func removeObservers() {
        if let observers = ScrollViewMetadata.keyboardObservers[self] {
            NotificationCenter.default.removeObserver(observers.showObserver, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(observers.hideObserver, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
}
