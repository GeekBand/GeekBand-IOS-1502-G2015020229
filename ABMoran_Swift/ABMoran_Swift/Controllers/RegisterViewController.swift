//
//  RegisterViewController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    @IBAction func registerButtonClicked(sender: AnyObject) {
        if (checkInput()){
            self.pleaseWait()
            
            let parameters = [
                "username":"\(userNameTextField.text!)",
                "password":"\(passwordTextField.text!)",
                "email":"\(emailTextField.text!)",
                "gbid":"G2015020229"
            ]
            
            Alamofire.request(.POST, "http://moran.chinacloudapp.cn/moran/web/user/register", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
                if error == nil{
                    let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    let message: String = json.objectForKey("message") as! String
                    self.clearAllNotice()
                    switch message
                    {
                    case "Register success":
                        dispatch_async(dispatch_get_main_queue(),{
                            self.dismissViewControllerAnimated(true, completion: nil)
                            self.noticeSuccess("注册成功!")
                        })
                    case "Email exists":
                        self.noticeError("该邮箱已被注册!")
                    default:self.noticeError("出错啦!")
                    }
                }
            }
        }
    }
    
    func checkInput() ->Bool{
        if(userNameTextField.text!.isEmpty)
        {
            self.noticeError("邮箱没有填写!")
            return false
        }
        if(emailTextField.text!.isEmpty)
        {
            self.noticeError("密码没有填写!")
            return false
        }
        if(passwordTextField.text?.characters.count<6 || passwordTextField.text?.characters.count>20)
        {
            self.noticeError("密码密码长度在6-20位之间!")
            return false
        }
        if(confirmPasswordTextField.text!.isEmpty)
        {
            self.noticeError("重复密码没有填写!")
            return false
        }
        if(passwordTextField.text != passwordTextField.text)
        {
            self.noticeError("两次密码不一致!")
            return false
        }
        return true
    }
    
    @IBAction func touchDownAction(textField: UITextField){
        textField.resignFirstResponder();
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = 0.3
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        UIView.commitAnimations()
        
    }
}