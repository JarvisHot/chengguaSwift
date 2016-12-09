//
//  ViewControllerThree.swift
//  ChengguaSwift
//
//  Created by jarvis on 2016/11/29.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

import UIKit

class ViewControllerThree: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "bgImg1991"), for: .default)
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
