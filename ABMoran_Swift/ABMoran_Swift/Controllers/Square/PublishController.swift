//
//  PublishController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/27/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation

class PublishController : UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,UITextViewDelegate{
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    let user = NSUserDefaults.standardUserDefaults();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.backgroundColor = UIColor(red: 230/255.0, green: 106/255.0, blue: 58/255.0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 230/255.0, green: 106/255.0, blue: 58/255.0, alpha: 1)
        self.navigationController!.navigationBar.alpha = 1.0
        self.textView.delegate = self;
        let title = UILabel(frame: CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30))
        title.text = "发布照片"
        title.textColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(title)
        
        makePublishButton()
        makeBackButton()
    }
    
    func makePublishButton(){
        let publishButton = UIBarButtonItem(title: "发布", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("publishButtonClicked"))
        self.navigationItem.rightBarButtonItem = publishButton;
    }
    
    func makeBackButton(){
        let backButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backButtonClicked"))
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    func backButtonClicked(){
        Navigator.GotoMainView()
    }
    
    func publishButtonClicked(){
        
    }
    
    func touchDown(sender: AnyObject){
    
    }
    
}