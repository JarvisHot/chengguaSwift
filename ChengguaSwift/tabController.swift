//
//  tabController.swift
//  ChengguaSwift
//
//  Created by jarvis on 2016/11/29.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

import UIKit

class tabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage=UIImage.init(named: "back88")
        let one:ViewControllerOne = ViewControllerOne.init(nibName: "ViewControllerOne",bundle: Bundle.main)
        
        one.tabBarItem.selectedImage=UIImage.init(named: "首页选中")?.withRenderingMode(.alwaysOriginal)
        one.tabBarItem.title="首页"
        one.tabBarItem.image=UIImage.init(named: "首页未选中")
        one.title="首页"
        let two:ViewControllerTwo = ViewControllerTwo.init(nibName:"ViewControllerTwo",bundle:Bundle.main)
        two.tabBarItem.selectedImage=UIImage.init(named: "社团选中")?.withRenderingMode(.alwaysOriginal)
        two.tabBarItem.image=UIImage.init(named: "社团-未选中")
        two.tabBarItem.title="社团"
       two.title="社团"
        let three:ViewControllerThree = ViewControllerThree.init(nibName:"ViewControllerThree",bundle:.main)
        three.tabBarItem.selectedImage=UIImage.init(named: "消息-选中")?.withRenderingMode(.alwaysOriginal)
        three.tabBarItem.image=UIImage.init(named: "消息")
       three.tabBarItem.title="消息"
        three.title="消息"
        let four:ViewControllerFour = ViewControllerFour.init(nibName:"ViewControllerFour",bundle: .main)
        four.tabBarItem.selectedImage=UIImage.init(named: "我的-选中")?.withRenderingMode(.alwaysOriginal)
        four.tabBarItem.image=UIImage.init(named: "我的")
        four.tabBarItem.title="我的"
        four.title="我的"
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 12.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.yellow], for: .selected)
        self.viewControllers=[UINavigationController.init(rootViewController: one),UINavigationController.init(rootViewController: two),UINavigationController.init(rootViewController: three),UINavigationController.init(rootViewController: four)];
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        

        // Do any additional setup after loading the view.
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
