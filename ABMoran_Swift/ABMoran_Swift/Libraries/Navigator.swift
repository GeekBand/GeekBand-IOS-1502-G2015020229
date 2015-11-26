//
//  Navigator.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/26/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    class func GotoSettings(){
        dispatch_async(dispatch_get_main_queue(),{
            let settingsStoryBoard = UIStoryboard(name: "Settings", bundle: nil)
            let main:NavigationController = settingsStoryBoard.instantiateViewControllerWithIdentifier("SettingsStoryboard") as! NavigationController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        })
    }
    
    class func GotoSquare() {
        dispatch_async(dispatch_get_main_queue(),{
            let settingsStoryBoard = UIStoryboard(name: "Settings", bundle: nil)
            let main:NavigationController = settingsStoryBoard.instantiateViewControllerWithIdentifier("SettingsStoryboard") as! NavigationController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        })
    }
    
    class func GotoLogin() {
        dispatch_async(dispatch_get_main_queue(),{
            let mainStoryBoard = UIStoryboard(name: "LoginAndRegister", bundle: nil)
            let main:LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginStoryboard") as! LoginViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        })
    }
}