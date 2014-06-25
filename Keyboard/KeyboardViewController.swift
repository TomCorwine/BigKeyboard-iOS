//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Tom Corwine on 6/19/14.
//  Copyright (c) 2014 Tom Corwine. All rights reserved.
//

import UIKit
import CoreMotion

let kButtonWidth = Float(44.0)
let kButtonHeight = Float(51.0)

let kButtonHPadding = Float(3.0)
let kButtonVPadding = Float(3.0)

let kScrollSensetivity = Float(8.0)

class KeyboardViewController: UIInputViewController
{
  let motionManager = CMMotionManager()
  var scrollView: UIScrollView?

  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.whiteColor()

    self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
    self.scrollView!.autoresizingMask = (.FlexibleWidth | .FlexibleHeight)
    self.scrollView!.showsHorizontalScrollIndicator = false
    self.inputView.addSubview(self.scrollView)

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
        var button = UIButton(frame: CGRect(x: h, y: v, width: kButtonWidth, height: kButtonHeight))
        button.backgroundColor = UIColor.darkGrayColor()
        button.setTitle(character, forState: .Normal)
        button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
        self.scrollView!.addSubview(button)
        h = h + kButtonWidth + kButtonHPadding
        
        if h > maxh
        {
          maxh = h
        }
      }

      row++
      v = v + kButtonHeight + kButtonVPadding
    }

    self.scrollView!.contentSize = CGSize(width: maxh, height: self.scrollView!.frame.size.height)

    var button = UIButton(frame: CGRectMake(kButtonHPadding, v, 50.0, kButtonHeight))
    button.backgroundColor = UIColor.darkGrayColor()
    button.setTitle("NXT", forState: .Normal)
    button.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
    self.inputView.addSubview(button)
    
    var x = button.frame.origin.x + button.frame.size.width + kButtonHPadding
    button = UIButton(frame: CGRectMake(x, v, 200.0, kButtonHeight))
    button.backgroundColor = UIColor.darkGrayColor()
    button.setTitle("space", forState: .Normal)
    button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
    self.inputView.addSubview(button)

    x = button.frame.origin.x + button.frame.size.width + kButtonHPadding
    button = UIButton(frame: CGRectMake(x, v, 60.0, kButtonHeight))
    button.backgroundColor = UIColor.darkGrayColor()
    button.setTitle("return", forState: .Normal)
    button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
    self.inputView.addSubview(button)
  }

  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)
    
    // Initial set keyboard scroll position to middle
    self.scrollView!.contentOffset.x = self.scrollViewMaxScroll() / 2.0

    // Activate gyro and provide block to move keyboard upon new gyro data
    self.motionManager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(gyroData: CMGyroData!, error: NSError!) in
      
      var yRot = Float(gyroData.rotationRate.y)
      var xPos = self.scrollView!.contentOffset.x
      var newPos = xPos + (yRot * kScrollSensetivity)
      if newPos >= Float(0.0) && newPos <= self.scrollViewMaxScroll()
      {
        self.scrollView!.contentOffset = CGPoint(x: newPos, y: 0.0)
      }
    })
  }
  
  override func viewWillDisappear(animated: Bool)
  {
    super.viewWillDisappear(animated)

    self.motionManager.stopGyroUpdates()
  }
}

extension KeyboardViewController
{
  func scrollViewMaxScroll() -> Float
  {
    return self.scrollView!.contentSize.width - self.scrollView!.frame.size.width
  }
}

extension KeyboardViewController
{
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
      proxy.insertText(character)
    }
  }
}
