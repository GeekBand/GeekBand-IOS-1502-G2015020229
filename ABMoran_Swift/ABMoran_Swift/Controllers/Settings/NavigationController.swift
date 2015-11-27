//
//  NavigationController.swift
//  ABMoran_Swift
//
//  Created by Arbin on 11/26/15.
//  Copyright © 2015 com.Geekband. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationBar.barTintColor = UIColor(red: 230/225.0, green: 160/225.0, blue: 58/225.0, alpha: 1)
    }
}