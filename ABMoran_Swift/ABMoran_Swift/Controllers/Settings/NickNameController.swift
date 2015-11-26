//
//  EditNickNameController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/26/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class NickNameController : UIViewController{
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    let user = NSUserDefaults.standardUserDefaults();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.nickNameTextField.text = user.stringForKey("user_name")!

    }
    
    @IBAction func doneBarButtonClicked(sender: AnyObject) {
        let parameters = [
            "user_id":user.stringForKey("user_id")!,
            "token":user.stringForKey("token")!,
            "new_name":nickNameTextField.text!
        ]
        self.pleaseWait()
        Alamofire.request(.POST, "http://moran.chinacloudapp.cn/moran/web/user/rename", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            self.clearAllNotice()
            if error == nil{
                let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                let message: String = json.objectForKey("message") as! String
            
                print(message)
                if message == "Update success"{
                    self.user.setObject(self.nickNameTextField.text!, forKey: "user_Name")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                    self.noticeSuccess("修改成功!")
                    NSNotificationCenter.defaultCenter().postNotificationName("updateUserName", object: self.nickNameTextField.text!)
                }
            }
        }
    }
}