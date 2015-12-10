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

    class func GotoSettings() {
        dispatch_async(dispatch_get_main_queue(), {
            let settingsStoryBoard = UIStoryboard(name: "Settings", bundle: nil)
            let main: NavigationController = settingsStoryBoard.instantiateViewControllerWithIdentifier("SettingsStoryboard") as! NavigationController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        })
    }

    class func GotoSquare() {
        dispatch_async(dispatch_get_main_queue(), {
            let squareStoryBoard = UIStoryboard(name: "Square", bundle: nil)
            let main: SquareController = squareStoryBoard.instantiateViewControllerWithIdentifier("SquareStoryBoard") as! SquareController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        })
    }

    class func GotoLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            let mainStoryBoard = UIStoryboard(name: "LoginAndRegister", bundle: nil)
            let main: LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginStoryboard") as! LoginViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        })
    }

    class func GotoPublish(image: UIImage) {
        dispatch_async(dispatch_get_main_queue(), {
            let settingsStoryBoard = UIStoryboard(name: "Publish", bundle: nil)
            let main: PublishController = settingsStoryBoard.instantiateViewControllerWithIdentifier("PublishStoryboard") as! PublishController
            main.img = image;
            let nav = UINavigationController(rootViewController: main)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = nav
        })
    }

    class func GotoDetail(picture: Picture) {
        dispatch_async(dispatch_get_main_queue(), {
            let detail = UIStoryboard(name: "ViewDetail", bundle: nil)
            let main: DetailController = detail.instantiateViewControllerWithIdentifier("ViewDetail") as! DetailController
            main.picture = picture
            let nav = UINavigationController(rootViewController: main)
            print("navigate to picture detail")
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = nav
        })
    }

    class func GotoComment(picture: Picture){
        dispatch_async(dispatch_get_main_queue(), {
            let comment = CommentController()
            comment.picture = picture
            let nav = UINavigationController(rootViewController: comment)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = nav
        })
    }

    class func GotoMainView() {
        dispatch_async(dispatch_get_main_queue(), {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

            let squareStoryBoard = UIStoryboard(name: "Square", bundle: nil)
            let squareVC: SquareController = squareStoryBoard.instantiateViewControllerWithIdentifier("SquareStoryBoard") as! SquareController
            let square = UINavigationController(rootViewController: squareVC)
            square.navigationBar.backgroundColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
            square.navigationBar.barTintColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
            square.tabBarItem.title = "广场"
            square.tabBarItem.image = UIImage(named: "square")

            let settingsStoryBoard = UIStoryboard(name: "Settings", bundle: nil)
            let settings: NavigationController = settingsStoryBoard.instantiateViewControllerWithIdentifier("SettingsStoryboard") as! NavigationController
            settings.tabBarItem.title = "我的"
            settings.tabBarItem.image = UIImage(named: "my")

            let viewWidth = UIScreen.mainScreen().bounds.size.width
            let photoButton = UIButton(frame: CGRectMake(viewWidth / 2 - 60, -25, 120, 50))
            photoButton.setImage(UIImage(named: "publish"), forState: UIControlState.Normal)
            photoButton.setImage(UIImage(named: "publish_hover"), forState: UIControlState.Highlighted)

            let imagePicker = ImagePicker(action: {
                (image) -> Void in
                Navigator.GotoPublish(image)
            })
            photoButton.addTarget(imagePicker, action: Selector("pickImage"), forControlEvents: UIControlEvents.TouchUpInside)

            appDelegate.tabBarController = UITabBarController()
            appDelegate.tabBarController.viewControllers = [square, imagePicker, settings]

            appDelegate.window!.rootViewController?.presentViewController(appDelegate.tabBarController, animated: true, completion: {})
            appDelegate.tabBarController.tabBar.addSubview(photoButton)
        })
    }
}