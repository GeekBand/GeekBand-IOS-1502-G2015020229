//
//  SquareController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/25/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SquareController: UITableViewController {

    @IBOutlet var titleButton: UIButton!
    let refresh = UIRefreshControl()
    let user = NSUserDefaults.standardUserDefaults();
    var dataSource:Array<Shop> = []
    var menuData = ["显示全部":["longitude":"121.47794","latitude":"31.22516","distance":"1000"],
                    "附近500米":["longitude":"121.47794","latitude":"31.22516","distance":"500"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleButton()

        refresh.attributedTitle = NSAttributedString(string: "下拉刷新")
        refresh.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresh)

        let parameters = [
                "user_id":user.stringForKey("user_id")!,
                "token":user.stringForKey("token")!,
                "longitude":"121.47794",
                "latitude":"31.22516"
        ]
        requestData(parameters)
    }

    func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refresh.endRefreshing()
    }

    func setTitleButton(){
        // set title button
        self.titleButton = UIButton(type: UIButtonType.Custom)
        self.titleButton.frame = CGRectMake(0, 0, 200, 35)
        self.titleButton.setTitle("全部",forState:UIControlState.Normal)
        self.titleButton.setImage(UIImage(named: "icon_arrow_down"), forState:UIControlState.Normal)
        self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
        self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        self.titleButton.addTarget(self, action: "titleButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = self.titleButton;
    }

    func titleButtonClicked(button:UIButton){
        var menus = [AnyObject!]()
        for (key,_) in menuData {
            let item = KxMenuItem()
            item.action = Selector("requestLocationData:")
            item.target = self
            item.title = key
            menus.append(item)
        }

        let keyWindow = UIApplication.sharedApplication().keyWindow
        let rect = button.superview?.convertRect(button.frame,toView: keyWindow)
        KxMenu.showMenuInView(keyWindow, fromRect: rect!,menuItems: menus)
    }

    func requestLocationData(button:KxMenuItem){
        var data = menuData[button.title]!
        data["user_id"] = user.stringForKey("user_id")!
        data["token"] = user.stringForKey("token")!
        requestData(data)
    }

    func requestData(parameters:Dictionary<String,String>){
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/node/list", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                let json = JSON(data: data!)
                let model = json["data"].dictionary
                for value in model!.values{
                    //print(value)
                    let shop = Shop()
                    shop.addr = value["node"]["addr"].string
                    for index in 0..<value["pic"].count{
                        let pic = value["pic"][index]
                        let picture = Picture()
                        picture.pic_link = pic["pic_link"].string
                        picture.node_id = pic["node_id"].string
                        picture.pic_id = pic["pic_id"].string
                        picture.user_id = pic["user_id"].string
                        picture.title = pic["title"].string
                        shop.pics.append(picture)
                    }
                    self.dataSource.append(shop)
                }
            }
            self.tableView.reloadData()
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tablecell", forIndexPath: indexPath) as! SquareTableCell
        cell.addreslab.text = self.dataSource[indexPath.row].addr
        cell.dataSource = self.dataSource[indexPath.row].pics
        return cell
    }
}