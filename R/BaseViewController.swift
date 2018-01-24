//
//  BaseViewController.swift
//  R
//
//  Created by dingshankeji on 2018/1/17.
//  Copyright © 2018年 Refuse. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var backgroundView : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        initUI()
    }
    func initUI () -> Void {
        let view1  = UIView(frame: CGRect(x: 100, y: 100, width: view.frame.size.width - 200, height: view.frame.size.height - 200));
        backgroundView = view1
        view .addSubview(view1);
        view1.backgroundColor = UIColor.white;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
