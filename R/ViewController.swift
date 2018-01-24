//
//  ViewController.swift
//  R
//
//  Created by dingshankeji on 2018/1/17.
//  Copyright © 2018年 Refuse. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: BaseViewController {

    lazy var buttonOne : UIButton = {
        let button = UIButton.init()
        button.frame = CGRect(x:100, y: 100, width: 100, height:100)
        button.setTitle("title", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action:#selector(buttonOneClick), for: .touchUpInside)

        return button;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonOne)
    }

    @objc func buttonOneClick() {
        print("this is click")
        
        let controller = newViewController.init()
        self.present(controller, animated: true, completion: nil)
        
//        return
        #if false
            
            let red     = CGFloat(arc4random()%256)/255.0
            let green   = CGFloat(arc4random()%256)/255.0
            let blue    = CGFloat(arc4random()%256)/255.0
            view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)

        #else
            view.backgroundColor = UIColor.init(red: CGFloat(arc4random()%256)/255.0 , green:  CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
        #endif
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    class func getName() -> (String) {
        return "jfdskfjsl"
    }
}

class newViewController: UIViewController {
    lazy var button2:UIButton = {
        let button:UIButton = UIButton(frame:CGRect(x:100, y:200, width:100, height:100))
        button.setTitle("back", for: .normal)
        button.setTitleColor(UIColor.yellow, for: .normal)
        button.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        return button
    }()
    lazy var button23:UIButton = {
        let button:UIButton = UIButton(frame:CGRect(x:200, y:200, width:100, height:100))
        button.setTitle("qingqiu ", for: .normal)
        button.setTitleColor(UIColor.yellow, for: .normal)
        button.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        return button
    }()
    
    @objc func dissmiss() {
        self.dismiss(animated:true , completion: nil)
    }
    
    @objc func reloadData() {

        let manager = AFHTTPSessionManager()
        var urlString = "http://www.baidu.com/test/xxx"
        urlString = "fdslfjsldf";
        let dictionary = ["key" : "value"];
        
        manager.post(urlString, parameters: dictionary, progress: { (progress) in
            
        }, success: { (task, responseObject) in
            print(responseObject ?? "")
        }) { (task, error) in
            print(error)
        }
        let nnn = urlString.count > 0 ? "111" : "222"
        print(nnn)
       
        
        var firstArray  = [Int]()
        firstArray.append(12)
        firstArray.remove(at: 0)
//        firstArray.count
        firstArray.removeAll()
        
        var secondArray = Array(firstArray)
        secondArray.append(12);
        secondArray += firstArray;
        var thirdArray = firstArray + secondArray;
        print ( thirdArray.count )
        if thirdArray.count > 0 {
            thirdArray.remove(at: 0)
        }
        
//        for (index, value) in thirdArray.enumerated() {
//
//
//        }
        
//        var dictionary    = [Int: String]()
        var namesOfIntegers = [Int : String]()

        namesOfIntegers[12] = "123"
        
        namesOfIntegers = [:];
        var firstDictionary : [String : String] = [:]
        firstDictionary["name"] = "张三"
//        firstDictionary["name"] = nil
//        firstDictionary.removeValue(forKey: "name")
        
        
        let keys1 = firstDictionary.keys
        let values = firstDictionary.values
        print(keys1, values)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        view.addSubview(button2)
        view.addSubview(button23)
    }
}

