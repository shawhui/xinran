//
//  SecondViewController.swift
//  R
//
//  Created by dingshankeji on 2018/1/17.
//  Copyright © 2018年 Refuse. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        
        var firstDictionary : [String : String] = [:]
        firstDictionary["name"] = "张三"
        let keys1 = Array(firstDictionary.keys)
        let values = Array(firstDictionary.values)
        for (index, item) in keys1.enumerated() {
            print(item, ":", values[index])
        }
        print(keys1, values)
        let array = ["1", "2", "3", "4", "5"]
        let array2 = ["11", "22", "33", "44", "55"]
        
        print(array, array2)
        print(array);
        
    }
}
