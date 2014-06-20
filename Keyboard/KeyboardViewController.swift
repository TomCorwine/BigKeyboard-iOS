//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Tom Corwine on 6/19/14.
//  Copyright (c) 2014 Tom Corwine. All rights reserved.
//

import UIKit

let kButtonWidth = Float(44.0)
let kButtonHeight = Float(51.0)

let kButtonHPadding = Float(3.0)
let kButtonVPadding = Float(3.0)

class KeyboardViewController: UIInputViewController
{
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.whiteColor()
    
    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)) as UIScrollView
    scrollView.autoresizingMask = (.FlexibleWidth | .FlexibleHeight)
    scrollView.showsHorizontalScrollIndicator = false
    self.view.addSubview(scrollView)

    var positions = [Float(0.0), Float(20.0), Float(40.0)]
    var characters1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    var characters2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    var characters3 = ["Z", "X", "C", "V", "B", "N", "M", "<"]

    var maxh = Float(0.0)
    var v = Float(0.0)
    var row = 0
    for characters in [characters1, characters2, characters3]
    {
      var h = Float(positions[row]) + kButtonHPadding
      for character in characters
      {
        var button = UIButton(frame: CGRect(x: h, y: v, width: kButtonWidth, height: kButtonHeight)) as UIButton
        button.backgroundColor = UIColor.darkGrayColor()
        button.setTitle(character, forState: .Normal)
        button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
        scrollView.addSubview(button)
        h = h + kButtonWidth + kButtonHPadding
        
        if h > maxh
        {
          maxh = h
        }
      }

      row++
      v = v + kButtonHeight + kButtonVPadding
    }

    scrollView.contentSize = CGSize(width: Float(maxh + kButtonHPadding), height: scrollView.frame.size.height)
    
    var button = UIButton(frame: CGRect(x: kButtonHPadding, y: v, width: 50.0, height: kButtonHeight)) as UIButton
    button.backgroundColor = UIColor.darkGrayColor()
    button.setTitle("NXT", forState: .Normal)
    button.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
    self.view.addSubview(button)
    
    var x = button.frame.origin.x + button.frame.size.width + kButtonHPadding
    button = UIButton(frame: CGRect(x: x, y: v, width: 200.0, height: kButtonHeight)) as UIButton
    button.backgroundColor = UIColor.darkGrayColor()
    button.setTitle("space", forState: .Normal)
    button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
    self.view.addSubview(button)

    x = button.frame.origin.x + button.frame.size.width + kButtonHPadding
    button = UIButton(frame: CGRect(x: x, y: v, width: 60.0, height: kButtonHeight)) as UIButton
    button.backgroundColor = UIColor.darkGrayColor()
    button.setTitle("return", forState: .Normal)
    button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
    self.view.addSubview(button)
  }
  
  func buttonPress(sender: UIButton)
  {
    var character = sender.titleForState(.Normal)
    var proxy = self.textDocumentProxy as UITextDocumentProxy
    
    if "<" == character
    {
      proxy.deleteBackward()
    }
    else if "space" == character
    {
      proxy.insertText(" ")
    }
    else if "return" == character
    {
      proxy.insertText("\n")
    }
    else
    {
      proxy.insertText(NSString(format: "%@", character))
    }
  }
}
