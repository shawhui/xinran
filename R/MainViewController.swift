//
//  MainViewController.swift
//  R
//
//  Created by dingshankeji on 2018/1/17.
//  Copyright © 2018年 Refuse. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var buttonNew : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isOpaque = false
        // self.tabBar.barTintColor = UIColor.red
        self.tabBar.tintColor = UIColor.red
        let vcArray:[UIViewController] = [FirstViewController(), ThirdViewController(), FouthViewController(), FifthViewController()]
        let titleArray = [("首页", "0"), ("订单", "1"), ("购物车", "2"), ("我的", "3")]
        for (index, vc) in vcArray.enumerated() {
            vc.tabBarItem.title = titleArray[index].0
            vc.title = titleArray[index].0
            vc.tabBarItem.image = UIImage(named: "tabbar_icon\(titleArray[index].1)")
            vc.tabBarItem.selectedImage = UIImage(named: "tabbar_icon\(titleArray[index].1)_s")
            
            let nav = UINavigationController(rootViewController: vc)
            addChildViewController(nav)
        }
    }

}
