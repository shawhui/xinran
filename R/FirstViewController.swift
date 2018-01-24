//
//  FirstViewController.swift
//  R
//
//  Created by dingshankeji on 2018/1/17.
//  Copyright © 2018年 Refuse. All rights reserved.
//

import UIKit

class FirstViewController:BaseViewController {
    
    var button : UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("click", for: UIControlState.normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitleColor(UIColor.cyan, for: UIControlState.normal)
        button.backgroundColor = UIColor.purple

        button.addTarget(self, action:#selector(buttonClick), for: UIControlEvents.touchUpInside)
        button.tag = 100;
        return button
    }()
    
    lazy var imageView : UIImageView = {
        let image = UIImageView(frame:CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: 170))
        image.contentMode = UIViewContentMode.scaleAspectFit
        image.image = UIImage(named: "banner")
        return image
    }()
    
    var cates   : Array = ["全部", "服饰", "搭配", "数码", "餐厨", "出行", "文具", "居家", "品牌"]
    var states  : Array = Array(arrayLiteral: "预热中", "预售中", "预售失败", "成功结束")
    var sorts   : Array = Array(arrayLiteral: "最热", "最新", "价格")
    
    lazy var menu : MoreDropDownMenu = {
        let time11 = MoreDropDownMenu.init(origin : CGPoint(x:0, y: 170 + 64), andHeight:50 )
        // time11?.backgroundColor = UIColor.red
        time11?.delegate = self
        time11?.dataSource = self
        time11?.finishedBlock = { (indexPath : MoreIndexPath!) in
            var string : String! = indexPath!.column == 0 ? self.cates[indexPath!.row] : indexPath!.column == 1 ? self.states[indexPath!.row] : indexPath!.column == 2 ? self.sorts[indexPath!.row] : "";
            print("点击了 ", string)
        };
//        - (void)selectIndexPath:(MoreIndexPath *)indexPath
        let indexPathText = MoreIndexPath(col: 1, row: 1)
        time11?.select( indexPathText )

//        time11?.selectIndexPath(MoreIndexPath(col: 2, row: 2) , triggerDelegate: true);// = MoreIndexPath(col: 0, row: 0)
        
//        time11?.select( MoreIndexPath(col: 2, row: 2) , triggerDelegate: true)
//        time11?.indexPath( MoreIndexPath(col: 2, row: 2) );
        return time11!
    }()
    
    @objc func buttonClick(button:UIButton) -> Void {
        
        let indexPathText = MoreIndexPath(col: 1, row: 1)
        menu.select( indexPathText )
        //var string : String = "13"
        //let string2 = String(button.tag)
        //let value1 = Int(string)
        //print(value1 ?? 0)
        //string = string + " " + string2 + " " + String(button.tag)
        //print(string)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.red
        self.title = "美之源"
//        let dict:NSDictionary = NSDictionary(object: UIColor.orange,  forKey:NSAttributedStringKey.foregroundColor as NSCopying )
//        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                                   NSAttributedStringKey.font : UIFont.systemFont(ofSize: 25)]
        navigationController?.navigationBar.barTintColor = UIColor.orange
        print(cates.count)
        setUpUI()
    }
}


//- (void)menu:(MoreDropDownMenu *)menu didSelectRowAtIndexPath:(MoreIndexPath *)indexPath;
//- (NSIndexPath *)menu:(MoreDropDownMenu *)menu willSelectRowAtIndexPath:(MoreIndexPath *)indexPath;
//- (void)didTapMenu:(MoreDropDownMenu *)menu;
extension FirstViewController : MoreDropDownMenuDelegate ,MoreDropDownMenuDataSource  {
    
    func numberOfColumns ( in menu : MoreDropDownMenu ) -> Int {
        return 3
    }
    
    
    //
    ///**
    // *  返回 menu 第column列 每行title
    // */
    //- (NSString *)menu:(MoreDropDownMenu *)menu titleForRowAtIndexPath:(MoreIndexPath *)indexPath;
    func menu (_ menu: MoreDropDownMenu, titleForRowAt indexPath: MoreIndexPath ) -> String {
        
        if  indexPath.column == 0 {
            if  cates.count <= 0 {
                return "未知";
            }
            return  cates[indexPath.row];
        } else if  indexPath.column == 1 {
            if  states.count <= 0 {
                return "未知";
            }
            return states[indexPath.row];
        } else {
            if  sorts.count <= 0 {
                return "未知";
            }
            return sorts[indexPath.row];
        }
    }
    
    
    ///**
    // *  返回 menu 第column列 标题集合
    // */
    //- (NSArray *)menu:(MoreDropDownMenu *)menu arrayForRowAtIndexPath:(MoreIndexPath *)indexPath;
    func menu (_ menu:MoreDropDownMenu, arrayForRowAt indexPath: MoreIndexPath ) -> Array<Any> {
        if (indexPath.column == 0) {
            return cates;
        } else if (indexPath.column == 1){
            return states;
        } else {
            return sorts;
        }
    }
    
    
    ///**
    // *  返回 menu 第column列有多少行
    // */
    //- (NSInteger)menu:(MoreDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
    func menu(_ menu:MoreDropDownMenu, numberOfRowsInColumn column: NSInteger ) -> Int {
        switch column {
        case 0:
            return cates.count
        case 1:
            return states.count
    
        case 2:
            return sorts.count
    
        default:
            return 0
        }
    }
}
//extension FirstViewController : UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
//}


extension FirstViewController  {
    func testFunction() {
        let string :  NSString! = "1000";
        var numberString : Int?
        numberString = Int(string as String)
        
        print(numberString ?? 1)
    }
}

extension FirstViewController {
    fileprivate func setUpUI() {
        view.addSubview(imageView)
        view.addSubview(menu)
//        view.addSubview(button)
        let spreadButton = ZYSpreadButton.init(backgroundImage: UIImage(named: "tabbar_icon0_s"), highlight: UIImage(named: "tabbar_icon1_s"), position: CGPoint(x:UIScreen.main.bounds.width - 35, y:UIScreen.main.bounds.height - 40 - 50))

        
//        let spreadButton = ZYSpreadButton(image: UIImage(named: "powerButton"),
//                                        highlightImage: UIImage(named: "powerButton_highlight"),
//                                        position: CGPointMake(40, UIScreen.mainScreen.bounds.height - 40))
        
        
        let btn1 = ZYSpreadSubButton.init(backgroundImage: UIImage(named: "tabbar_icon0_s"),
                                          highlight: UIImage(named: "tabbar_icon0_s")) { (index, sender) -> Void in
                                            print("first button be clicked!!!")
        }
        
        let btn2 = ZYSpreadSubButton(backgroundImage: UIImage(named: "tabbar_icon0_s"),
                                     highlight: UIImage(named: "tabbar_icon0_s")) { (index, sender) -> Void in
                                        print("second button be clicked!!!")
        }
        let btn3 = ZYSpreadSubButton.init(backgroundImage: UIImage(named: "tabbar_icon0_s"),
                                          highlight: UIImage(named: "tabbar_icon0_s")) { (index, sender) -> Void in
                                            print("first button be clicked!!!")
        }
        
        let btn4 = ZYSpreadSubButton(backgroundImage: UIImage(named: "tabbar_icon0_s"),
                                     highlight: UIImage(named: "tabbar_icon0_s")) { (index, sender) -> Void in
                                        print("second button be clicked!!!")
        }
        spreadButton?.subButtons = [btn1 as Any, btn2 as Any, btn3 as Any, btn4 as Any]
        
        spreadButton?.mode = SpreadModeSickleSpread
        spreadButton?.direction = SpreadDirectionLeftUp
        spreadButton?.positionMode = SpreadPositionModeFixed
//        spreadButton?.positionMode = SpreadPositionModeTouchBorder

        /*  and you can assign a newValue to change the default
         spreadButton?.animationDuring = 0.2
         spreadButton?.animationDuringClose = 0.25
         spreadButton?.radius = 180
         spreadButton?.coverAlpha = 0.3
         spreadButton?.coverColor = UIColor.yellowColor()
         spreadButton?.touchBorderMargin = 10.0
         */
        
        
//        spreadButton?.buttonWillSpreadBlock = { print(CGRectGetMaxY(($0?.frame)!)) }
        spreadButton?.buttonWillSpreadBlock = { _ in
            print("will spread")
        };
        spreadButton?.buttonDidSpreadBlock = { _ in
            print("did spread") }
        spreadButton?.buttonWillCloseBlock = { _ in
            print("will closed") }
        spreadButton?.buttonDidCloseBlock = { _ in
            print("did closed") }
        
        if spreadButton != nil {
            self.view.addSubview(spreadButton!)
        }
    }
    
}

