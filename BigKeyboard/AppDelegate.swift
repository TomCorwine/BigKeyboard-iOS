//
//  AppDelegate.swift
//  BigKeyboard
//
//  Created by Tom Corwine on 6/19/14.
//  Copyright (c) 2014 Tom Corwine. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool
  {
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window!.backgroundColor = UIColor.whiteColor()
    self.window!.makeKeyAndVisible()
    self.window!.rootViewController = ViewController()
    return true
  }
}

