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
}