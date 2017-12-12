//
//  AutomaticallyAdjustContentOffsetViewController.swift
//  KeyboardMaster_Example
//
//  Created by Lucas Best on 12/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class AutomaticallyAdjustContentOffsetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scrollView:UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.registerForKeyboardEvents(automaticallyAdjustContentOffset: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.deregisterFromKeyboardEvents()
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
