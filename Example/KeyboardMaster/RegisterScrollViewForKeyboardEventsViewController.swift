//
//  RegisterScrollViewForKeyboardEventsViewController.swift
//  KeyboardMaster
//
//  Created by Lucas Best on 12/06/2017.
//  Copyright (c) 2017 Lucas Best. All rights reserved.
//

import UIKit
import KeyboardMaster

class RegisterScrollViewForKeyboardEventsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scrollView:UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.registerForKeyboardEvents()
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

