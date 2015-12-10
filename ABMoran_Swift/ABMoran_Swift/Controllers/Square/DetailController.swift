//
//  DetailController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 12/9/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var photoImage: UIImageView!
    var tableView: UITableView  =   UITableView()
    var picture: Picture!
    var dataSource: Array<Comment> = []
    let user = NSUserDefaults.standardUserDefaults();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.backgroundColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
        self.navigationController!.navigationBar.alpha = 1.0
        let backButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backButtonClicked"))
        self.navigationItem.leftBarButtonItem = backButton

        let commentButton = UIBarButtonItem(title: "评论", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("commentButtonClicked"))
        self.navigationItem.rightBarButtonItem = commentButton

        print("loading image \(self.picture.pic_link)")
        photoImage.sd_setImageWithURL(NSURL(string: self.picture.pic_link!))
        //add table view

        let height = self.photoImage.frame.size.height + self.navigationController!.navigationBar.frame.size.height
        self.tableView.frame         =   CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height)
        self.tableView.delegate      =   self
        self.tableView.dataSource    =   self
        self.tableView.registerClass(CommentsTableCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)

        loadingData(self.picture.pic_id)
    }

    func loadingData(pic_id: String) {
        let parameters = [
                "user_id": user.stringForKey("user_id")!,
                "token": user.stringForKey("token")!,
                "pic_id": pic_id
        ]
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/comment", parameters: parameters).response {
            (request, urlresquest, data, error) -> Void in
            if error == nil {
                let json = JSON(data: data!)
                //print(json)
                let model = json["data"].array
                for value in model! {
                    print(value)
                    let comment = Comment()
                    comment.comment = value["comment"].string
                    comment.created = value["created"].string
                    comment.modified = value["modified"].string
                    comment.id = value["id"].string
                    comment.user_id = value["user_id"].string
                    comment.shop_id = value["shop_id"].string
                    comment.pic_id = value["pic_id"].string
                    self.dataSource.append(comment)
                }
                self.tableView.reloadData()
            }
        }
    }

    func backButtonClicked() {
        Navigator.GotoMainView()
    }

    func commentButtonClicked(){
        Navigator.GotoComment(picture)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 600;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CommentsTableCell
        cell.comment = self.dataSource[indexPath.row]
        cell.loadData()
        return cell
    }
}