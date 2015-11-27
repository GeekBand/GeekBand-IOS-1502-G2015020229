//
//  AvatarController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/26/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AvatarController : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var pickerController: UIImagePickerController!
    
    let user = NSUserDefaults.standardUserDefaults();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headImageView.layer.cornerRadius = CGRectGetHeight(headImageView.bounds) / 2
        headImageView.layer.masksToBounds = true;
        
        headImageView.layer.cornerRadius = 16;
        headImageView.layer.cornerRadius = 16
        getAvatar()
    }
    
    func getAvatar(){
        let parameters = [
            "user_id":user.objectForKey("user_id")!
        ]
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/user/show", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                self.headImageView.image = UIImage(data: data!)
            }else{
                print(error);
            }
        }
    }
    
//    func scaleToSize(size: CGSize, image:UIImage)->UIImage{
//        UIGraphicsBeginImageContext(size);
//        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
//        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return scaledImage;
//    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        self.pleaseWait()
        let imageData:NSData = UIImageJPEGRepresentation(headImageView.image!,0.1)!
        let request = NSMutableURLRequest(URL: NSURL(string: "http://moran.chinacloudapp.cn/moran/web/user/avatar")!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 10
        
        let form:BLMultipartForm = BLMultipartForm()
        form.addValue(user.stringForKey("user_id")!, forField: "user_id")
        form.addValue(user.stringForKey("token")!, forField: "token")
        form.addValue(imageData, forField: "data")
        
        request.addValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        request.HTTPBody = form.httpBody()
        
        let session = NSURLSession.sharedSession()
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            self.clearAllNotice()
            if error == nil{
                let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                let message: String = json.objectForKey("message") as! String
                if message == "Update success"{
                    dispatch_async(dispatch_get_main_queue(),{
                        NSNotificationCenter.defaultCenter().postNotificationName("updateAvatar", object: nil)
                        self.noticeSuccess("上传成功!")
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    })
                }
                else{
                    dispatch_async(dispatch_get_main_queue(),{
                        self.noticeError("上传失败!")
                    })
                }
            }
        }
        task.resume()
    }

    @IBAction func editHeadImageClicked(sender: AnyObject) {
        let picker = UIImagePickerController()
        let alert = UIAlertController(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: {
            (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
//        let imagePicker = ImagePicker(action: { (image) -> Void in
//            Navigator.GotoPublish(image)
//        })
//        imagePicker.pickImage()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        headImageView.image = image //scaleToSize(CGSize(width: 100,height: 100), image: image!);
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func CancelEdit(sender: AnyObject) {
        self.clearAllNotice()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}