//
//  LoginViewController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,UITextFieldDelegate  {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let user = NSUserDefaults.standardUserDefaults();
    
    @IBAction func loginButtonClicked(sender: AnyObject) {

        if(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
        {
            self.noticeError("邮箱和密码不能为空")
            return
        }
        
        self.pleaseWait()
        
        let parameters = [
            "email":"\(emailTextField.text!)",
            "password":"\(passwordTextField.text!)"
        ]
        
        Alamofire.request(.POST, "http://moran.chinacloudapp.cn/moran/web/user/login", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            self.clearAllNotice()
            if error == nil{
                let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                let message: String = json.objectForKey("message") as! String
                switch message
                {
                case "Login success":
                    let data = json.objectForKey("data")!;
                    self.user.setObject(data.objectForKey("user_id"), forKey: "user_id")
                    self.user.setObject(data.objectForKey("user_name"), forKey: "user_name")
                    self.user.setObject(data.objectForKey("token"), forKey: "token")
                    self.user.setObject(self.emailTextField.text, forKey: "user_Email")
                    self.user.setObject("G2015020229", forKey: "gbid")
                    Navigator.GotoMainView()
                case "No such user":
                    self.noticeError("账户不存在!")
                case "Wrong password":
                    self.noticeError("密码不正确!")
                default:self.noticeError("出错啦!")
                }
            }else{
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.text = "278726743@qq.com";
        self.passwordTextField.text = "278726743";
        self.emailTextField.delegate = self;
        self.passwordTextField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
