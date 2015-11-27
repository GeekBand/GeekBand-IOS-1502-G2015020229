//
//  AppDelegate.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    var window: UIWindow?
    var tabBarController:UITabBarController!
    var pickerController:UIImagePickerController!
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let user = NSUserDefaults.standardUserDefaults()
        if (user.objectForKey("token") != nil){
            GotoMainView()
        }else{
            Navigator.GotoLogin()
        }
        
        // Override point for customization after application launch.
        return true
    }
    
    func GotoMainView() {
        dispatch_async(dispatch_get_main_queue(),{
            let squareStoryBoard = UIStoryboard(name: "Square", bundle: nil)
            let squareVC:SquareController = squareStoryBoard.instantiateViewControllerWithIdentifier("SquareStoryBoard") as! SquareController
            let square = UINavigationController(rootViewController: squareVC)
            square.navigationBar.barTintColor = UIColor(red: 230/225.0, green: 160/225.0, blue: 58/225.0, alpha: 1)
            square.tabBarItem.title = "广场"
            square.tabBarItem.image = UIImage(named: "square")
            
            
            let settingsStoryBoard = UIStoryboard(name: "Settings", bundle: nil)
            let settings:NavigationController = settingsStoryBoard.instantiateViewControllerWithIdentifier("SettingsStoryboard") as! NavigationController
            settings.tabBarItem.title = "我的"
            settings.tabBarItem.image = UIImage(named: "my")
            
            let viewWidth = UIScreen.mainScreen().bounds.size.width
            let photoButton = UIButton(frame:CGRectMake(viewWidth/2-60,-25,120,50))
            photoButton.setImage(UIImage(named: "publish"), forState: UIControlState.Normal)
            //photoButton.setImage(UIImage(named: "publish_hover"), forState: UIControlState.Highlighted)
            photoButton.addTarget(self, action: Selector("photoButtonClicked"), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.tabBarController = UITabBarController()
            self.tabBarController.viewControllers = [square,settings]
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(self.tabBarController, animated:true ,completion:{})
            self.tabBarController.tabBar.addSubview(photoButton)
        })
    }
    
    func photoButtonClicked(){
        let picker = UIImagePickerController()
        let alert = UIAlertController(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.tabBarController.presentViewController(picker, animated:true ,completion:nil)
        }))
        alert.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: {
            (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.tabBarController.presentViewController(picker, animated:true ,completion:nil)
        }))
        self.tabBarController.presentViewController(alert, animated:true ,completion:nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        Navigator.GotoPublish(image!)
        self.tabBarController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

