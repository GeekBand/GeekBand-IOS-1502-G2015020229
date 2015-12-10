//
// Created by Arbin on 12/10/15.
// Copyright (c) 2015 com.Geekband. All rights reserved.
//

import Foundation
import Alamofire

class CommentController: UIViewController, UITextFieldDelegate {
    var pic_id: String!
    var comment: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.backgroundColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
        self.navigationController!.navigationBar.alpha = 1.0
        let backButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backButtonClicked"))
        self.navigationItem.leftBarButtonItem = backButton
        let commentButton = UIBarButtonItem(title: "评论", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("commentButtonClicked"))
        self.navigationItem.rightBarButtonItem = commentButton

        self.view.backgroundColor = UIColor.whiteColor()

        // add comment
        self.comment = UITextField(frame: CGRectMake(20, 100, self.view.frame.width - 40, 40));
        self.comment.borderStyle = UITextBorderStyle.RoundedRect
        self.comment.placeholder = "评价一下..."
        self.comment.delegate = self
        self.view.addSubview(self.comment)
    }

    func commentButtonClicked() {
        // save comment
        
    }

    func backButtonClicked() {
        Navigator.GotoMainView()
    }
}
