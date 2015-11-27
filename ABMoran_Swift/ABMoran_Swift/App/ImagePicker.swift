//
//  ImagePicker.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/27/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit

class ImagePicker : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var action:((UIImage) -> ())?;

    convenience init(action :(UIImage) -> () ) {
        self.init()
        self.action = action
    }
    
    func pickImage(){
        let picker = UIImagePickerController()
        let alert = UIAlertController(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
        
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker, animated:true ,completion:nil)
        }))
        alert.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: {
            (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(picker, animated:true ,completion:nil)
        }))
        self.presentViewController(alert, animated:true ,completion:nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        self.action!(image!);
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}