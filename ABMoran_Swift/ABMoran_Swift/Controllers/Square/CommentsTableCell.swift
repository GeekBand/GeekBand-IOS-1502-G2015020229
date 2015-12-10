//
// Created by Arbin on 12/10/15.
// Copyright (c) 2015 com.Geekband. All rights reserved.
//

import Foundation
import Alamofire

class CommentsTableCell: UITableViewCell {
    var headImageOfComment: UIImageView!
    var userNameOfComment: UILabel!
    var dateOfComment: UILabel!
    var textOfComment: UILabel!
    var comment: Comment!

    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let width = UIScreen.mainScreen().bounds.size.width;
        let font = UIFont(name: "Heiti SC",size: 14)
        
        self.headImageOfComment = UIImageView(frame:CGRectMake(12, 10, 40, 40))
        self.headImageOfComment.layer.cornerRadius = 20
        self.addSubview(self.headImageOfComment)

        self.userNameOfComment = UILabel(frame:CGRectMake(12+60+9, 7, width-24-60-18-100, 18))
        self.userNameOfComment.textColor = UIColor.blueColor()
        self.userNameOfComment.font = font
        self.addSubview(self.userNameOfComment)

        self.textOfComment = UILabel(frame:CGRectMake(12+60+9, 30, width-24-60-18, 18))
        self.textOfComment.textColor = UIColor.blueColor()
        self.textOfComment.font = font
        //multiline

        self.textOfComment.lineBreakMode = .ByWordWrapping
        self.textOfComment.numberOfLines = 0
        self.addSubview(self.textOfComment)

        self.dateOfComment = UILabel(frame:CGRectMake(width-90-24, 7, 100, 18))
        self.dateOfComment.textColor = UIColor.blueColor()
        self.dateOfComment.font = font
        self.addSubview(self.dateOfComment)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func loadData() {
        self.userNameOfComment.text = comment.user_id
        self.dateOfComment.text = comment.modified.substringToIndex(comment.modified.startIndex.advancedBy(10))
        self.textOfComment.text = comment.comment
        self.textOfComment.sizeToFit()
        getAvatar(comment.user_id)
    }

    func getAvatar(user_id:String){
        let parameters = ["user_id":user_id]
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/user/show", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                let img = UIImage(data: data!);
                self.headImageOfComment.image = img
            }
        }
    }
}
