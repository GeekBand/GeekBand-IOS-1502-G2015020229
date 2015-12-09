//
//  DetailController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 12/9/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit

class DetailController: UIViewController { //}, UITableViewDataSource, UITableViewDelegate {
    var picture: Picture!
    var comments: NSArray!
    @IBOutlet weak var photoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading image \(self.picture.pic_link)")
        photoImage.sd_setImageWithURL(NSURL(string: self.picture.pic_link!))
    }
}