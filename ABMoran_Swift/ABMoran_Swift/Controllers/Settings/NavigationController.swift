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
        self.navigationBar.backgroundColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
        self.navigationBar.barTintColor = UIColor(red: 230 / 255.0, green: 106 / 255.0, blue: 58 / 255.0, alpha: 1)
    }
}