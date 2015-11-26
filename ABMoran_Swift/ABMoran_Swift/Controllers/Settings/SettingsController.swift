//
//  SettingsController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/26/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SettingsController: UITableViewController {
  
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    let user = NSUserDefaults.standardUserDefaults();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headImageView.layer.cornerRadius = CGRectGetHeight(self.headImageView.bounds) / 2
        headImageView.layer.masksToBounds = true
        
        self.nickNameLabel.text = user.stringForKey("user_name")!
        self.emailLabel.text = user.stringForKey("user_Email")!
        
        getAvatar(nil)
        
        //regesite event
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "updateNickname:", name: "updateUserName", object: nil)
        center.addObserver(self, selector: "getAvatar:", name: "updateAvatar", object: nil)
    }
    
    func getAvatar(val:NSNotification?){
        let parameters = [
            "user_id":user.objectForKey("user_id")!
        ]
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/user/show", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                self.headImageView.image = UIImage(data: data!)
            }
        }
    }
    
    func updateNickname(val:NSNotification)
    {
        let str = val.object as! String
        self.nickNameLabel.text = str
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0)
        {
            if(indexPath.row == 2)
            {
                let alert = UIAlertController(title: nil, message: "你确定要注销当前用户么?", preferredStyle:UIAlertControllerStyle.ActionSheet)
                alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
                alert.addAction(UIAlertAction(title: "注销", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("token")
                    let loginStoryBoard = UIStoryboard(name: "LoginAndRegister", bundle: nil)
                    let main:LoginViewController = loginStoryBoard.instantiateViewControllerWithIdentifier("LoginStoryboard") as! LoginViewController
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = main
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        if (indexPath.section==1){
            if(indexPath.row == 0)
            {
                //评价
                let appid = "123456"
                let appstoreUrlString = String(format: "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appid)
                UIApplication.sharedApplication().openURL(NSURL(string:appstoreUrlString)!)
            }
            if(indexPath.row == 1)
            {
                //关注
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}