//
//  ViewControllerTwo.swift
//  ChengguaSwift
//
//  Created by jarvis on 2016/11/29.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

import UIKit
import Spring
class ViewControllerTwo: UIViewController {

   
    @IBOutlet weak var anbutton: SpringButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "bgImg1991"), for: .default)
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        anbutton.animation="squeezeUp"
        //        anbutton.y+=50
        anbutton.animate()
    }

    
    @IBAction func buttonClick(_ sender: SpringButton) {
//        anbutton.y=300
        anbutton.animation="squeezeDown"
        anbutton.animate()
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
