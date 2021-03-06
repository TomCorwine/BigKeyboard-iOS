//
//  ViewController.swift
//  BigKeyboard
//
//  Created by Tom Corwine on 6/19/14.
//  Copyright (c) 2014 Tom Corwine. All rights reserved.
//

import UIKit

let kScrollSensetivityKey = "kScrollSensetivityKey"

class ViewController: UIViewController, UITextFieldDelegate
{
  @IBOutlet var textField : UITextField
  @IBOutlet var secureTextField : UITextField
  @IBOutlet var label : UILabel
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    // Show keyboard on start
    self.textField.becomeFirstResponder()
    self.textField.delegate = self
    
    self.secureTextField.delegate = self
  }
  
  // Hook so new line can be detected
  func textFieldShouldReturn(textField: UITextField!) -> Bool
  {
    // Show label to indicate new line was inserted
    self.label.hidden = false
    
    // Hide label after half a second
    let delay = 0.5 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_current_queue(), {
      self.label.hidden = true
    })

    return true
  }
}
