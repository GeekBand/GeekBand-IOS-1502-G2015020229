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
    
    let user = NSUserDefaults.standardUserDefaults();
    var dataSource:Array<Shop> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters = [
            "user_id":user.stringForKey("user_id")!,
            "token":user.stringForKey("token")!,
            "longitude":"121.47794",
            "latitude":"31.22516"
        ]
        
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