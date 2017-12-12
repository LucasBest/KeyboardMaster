//
//  UIScrollView+Keyboard.swift
//  KeyboardMaster
//
//  Created by Lucas Best on 12/6/17.
//

import UIKit

public extension UIScrollView{
    private struct ScrollViewMetadata{
        static var contentInsetBeforeKeyboard = [UIScrollView: UIEdgeInsets]()
        static var keyboardGoingUpForScrollView = [UIScrollView: Bool]()
        static var automaticallyAdjustContentOffset = [UIScrollView: Bool]()
        static var keyboardObservers = [UIScrollView: (showObserver:Any, hideObserver:Any)]()
    }
    
    public func registerForKeyboardEvents(automaticallyAdjustContentOffset:Bool =  false){
        self.deregisterFromKeyboardEvents()
        
        ScrollViewMetadata.automaticallyAdjustContentOffset[self] = automaticallyAdjustContentOffset
        
        let showObserver = NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            ScrollViewMetadata.keyboardGoingUpForScrollView[self] = true
            self.updateKeyboardFrame(from: notification)
        }
        
        let hideObserver = NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            ScrollViewMetadata.keyboardGoingUpForScrollView[self] = false
            self.updateKeyboardFrame(from: notification)
        }
        
        ScrollViewMetadata.keyboardObservers[self] = (showObserver:showObserver, hideObserver:hideObserver)
    }
    
    public func deregisterFromKeyboardEvents(){
        self.removeObservers()
        
        ScrollViewMetadata.contentInsetBeforeKeyboard.removeValue(forKey: self)
        ScrollViewMetadata.keyboardGoingUpForScrollView.removeValue(forKey: self)
        ScrollViewMetadata.automaticallyAdjustContentOffset.removeValue(forKey: self)
        ScrollViewMetadata.keyboardObservers.removeValue(forKey: self)
    }
    
    private func updateKeyboardFrame(from notification:Notification){
        let keyboardGoingUp = ScrollViewMetadata.keyboardGoingUpForScrollView[self] ?? false
        
        if keyboardGoingUp{
            ScrollViewMetadata.contentInsetBeforeKeyboard = [self : self.contentInset]
        }
        
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect{
            let convertedKeyboardFrame = self.superview?.convert(keyboardFrame, from: nil) ?? keyboardFrame
            
            let intersectionRect = self.frame.intersection(convertedKeyboardFrame)
    
            var newContentInset = self.contentInset
            
            let newContentInsetBottom = self.frame.origin.y + self.frame.size.height - intersectionRect.origin.y
           
            if newContentInsetBottom > 0{
                newContentInset.bottom = newContentInsetBottom
            }
            else{
                newContentInset.bottom = ScrollViewMetadata.contentInsetBeforeKeyboard[self]?.bottom ?? 0.0
            }
            
            self.contentInset = newContentInset
            self.scrollIndicatorInsets = newContentInset
            
            if ScrollViewMetadata.automaticallyAdjustContentOffset[self] ?? false && keyboardGoingUp{
                let scrolledToBottom = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom
                
                let potentialNewContentOffset = self.contentOffset.y + newContentInsetBottom
                
                let newScrollPosition = CGFloat.minimum(potentialNewContentOffset, scrolledToBottom)
                
                if self.yOffsetWouldScrollUp(yOffset: newScrollPosition){
                    var contentOffset = self.contentOffset
                    contentOffset.y = newScrollPosition
                        
                    self.contentOffset = contentOffset
                }
            }
        }
    }
    
    private func yOffsetWouldScrollUp(yOffset:CGFloat) -> Bool{
        return yOffset >= self.contentOffset.y
    }
    
    private func removeObservers(){
        if let observers = ScrollViewMetadata.keyboardObservers[self]{
            NotificationCenter.default.removeObserver(observers.showObserver, name: Notification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(observers.hideObserver, name: Notification.Name.UIKeyboardWillHide, object: nil)
        }
    }
}
