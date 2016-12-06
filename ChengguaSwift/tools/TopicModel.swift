//
//  TopicModel.swift
//  ChengguaSwift
//
//  Created by jarvis on 2016/11/30.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

import UIKit

class TopicModel: NSObject {
    var certifiedname = String()
    var headurl = String()
    var isreward = NSNumber()
    var isvideo = NSNumber()
    var lable = NSArray()
    
    var lastreplytime = String()
    var replay = NSArray()
    var roleid = NSNumber()
    var sex = NSNumber()
    
    var title = String()
    var titleIstop = NSNumber()
    var titlePraiseNum = NSNumber()
    var titleid = NSNumber()
    var titlereply = NSNumber()
    
    var titlescan = NSNumber()
    
    var topicImg = NSArray()
    var topicIspraise = NSNumber()
    
    var topiccontent = String()
    var userName = String()
    var usercertified = NSNumber()
    var userid = NSNumber()
    var imgwidth = NSNumber()
    var imgHeight = NSNumber()
    
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("undefindKey--\(key)")
    }
    
    
    
    
    
}
