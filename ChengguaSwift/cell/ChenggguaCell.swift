//
//  ChenggguaCell.swift
//  ChengguaSwift
//
//  Created by jarvis on 2016/12/5.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

import UIKit
import SwiftDefine
protocol ChengguaCellDelegate {
    func didClickImageTagWithModel(_ tag:Int,model:TopicModel)
}
class ChenggguaCell: UITableViewCell {
    var delegate : ChengguaCellDelegate?
    var _model = TopicModel()
    
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var headerButton: UIButton!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var role: UILabel!

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var title: UILabel!
   
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var imageBack: UIView!
    @IBOutlet weak var imageBackTop: NSLayoutConstraint!
    @IBOutlet weak var imageBackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var replyHeight: NSLayoutConstraint!
    @IBOutlet weak var replyTop: NSLayoutConstraint!
    @IBOutlet weak var alluser: UIView!
    @IBOutlet weak var replyButton: UIButton!
   
    @IBOutlet weak var zan: UIButton!
    
    @IBOutlet weak var replyNum: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func ConfigWithModel (model:TopicModel) {
        _model=model
        headImage.sd_setImage(with: NSURL.init(string: model.headurl) as! URL, placeholderImage: UIImage.init(named: "guagua"))
        if model.sex.intValue==1 {
            headerButton.setBackgroundImage(UIImage.init(named: "红色"), for: .normal)
        }else{
            headerButton.setBackgroundImage(UIImage.init(named: "蓝色"), for: .normal)
        }
        nickName.text=model.userName
        role.text=model.certifiedname
        time.text=compareCurrentTime(time: model.lastreplytime)
        let titleAttStr = NSMutableAttributedString.init(string: model.title)
        let titleStyle = NSMutableParagraphStyle()
        titleStyle.lineBreakMode=NSLineBreakMode.byTruncatingTail
        titleStyle.lineSpacing=5
        titleAttStr.addAttributes([NSParagraphStyleAttributeName:titleStyle,NSFontAttributeName:UIFont.init(name: "HiraginoSans-W3", size: 17) as Any], range: NSRange.init(location: 0, length: titleAttStr.length))
        title.attributedText=titleAttStr
        
        let contentAttStr = NSMutableAttributedString.init(string: model.topiccontent)
        let contentStyle = NSMutableParagraphStyle()
        contentStyle.lineBreakMode=NSLineBreakMode.byTruncatingTail
        contentStyle.lineSpacing=5
        contentAttStr.addAttributes([NSParagraphStyleAttributeName:contentStyle,NSFontAttributeName:UIFont.init(name: "HiraginoSans-W3", size: 15)!,NSForegroundColorAttributeName:UIColor.init(red: 149/255.0, green: 145/255.0, blue: 157/255.0, alpha: 1)], range: NSMakeRange(0, model.topiccontent.characters.count))
        content.attributedText=contentAttStr
        for (_,value) in imageBack.subviews.enumerated(){
//            print("--index-\(index)----value-\(value)")
            value.removeFromSuperview()
        }
        if model.topicImg.count>0 {
            imageBackTop.constant=8
            if model.topicImg.count==1{
                let imageBtn = UIButton.init(type: .custom)
                imageBtn.tag=0
                var oldStr:String = model.topicImg[0] as! String
                var buttonWidth = CGFloat(0)
                
                if model.imgHeight.intValue==0 || model.imgHeight.isKind(of: NSNull.classForCoder()) {
                    buttonWidth=CGFloat(200)
                    if oldStr.hasPrefix("http://7xs9oh") {
                        if oldStr.contains("-thumb"){
                            oldStr = oldStr.replacingOccurrences(of: "-thumb", with: "-cutsmallmap")
                        }else{
                            oldStr=oldStr + "-cutsmallmap"
                        }
                    }
                }else{
                    buttonWidth=CGFloat(model.imgwidth.floatValue/model.imgHeight.floatValue*200)
                }
                imageBtn.sd_setImage(with: NSURL.init(string:oldStr)as! URL, for: .normal)
                var btnheight = CGFloat(200)
                let ImgScale = CGFloat((SwiftDefine.screenWidth()-CGFloat(100))*2/3+CGFloat(10)/CGFloat(200))
                if model.imgwidth.intValue  != 0 && model.imgHeight.intValue != 0 && CGFloat(model.imgwidth.floatValue/model.imgHeight.floatValue)>ImgScale {
                    buttonWidth=CGFloat((SwiftDefine.screenWidth()-CGFloat(100))*2/3+CGFloat(10))
                    btnheight=buttonWidth / CGFloat(model.imgwidth.floatValue/model.imgHeight.floatValue)
                }
                imageBackHeight.constant=btnheight
                imageBtn.frame=CGRect.init(x: 0, y: 0, width: buttonWidth, height: btnheight)
                if model.isvideo.intValue==1 {
                    imageBtn.setImage(UIImage.init(named: "视频播放"), for: .normal)
                }else{
                    //这里添加点击事件
                }
                imageBack.addSubview(imageBtn)
            }else{
                imageBackHeight.constant=(SwiftDefine.screenWidth()-CGFloat(100))/CGFloat(3)
                var count = 0
                if model.topicImg.count>3 {
                    count=3
                }else{
                    count=model.topicImg.count
                }
                for i in 0 ..< count{
                    let btn = UIButton.init(type: .custom)
                    btn.tag=i
                    var oldStr:String = model.topicImg[i] as! String
                    if oldStr.hasPrefix("http://7xs9oh") {
                        if oldStr.contains("-thumb"){
                            oldStr = oldStr.replacingOccurrences(of: "-thumb", with: "-cutsmallmap")
                        }else{
                            oldStr=oldStr + "-cutsmallmap"
                        }
                    }
                    let x = ((SwiftDefine.screenWidth()-CGFloat(100))/3+CGFloat(10))*CGFloat(i)
                    let wh = CGFloat(SwiftDefine.screenWidth()-CGFloat(100))/3
                    btn.frame=CGRect.init(x: x, y: 0, width: wh, height: wh)
                    btn.sd_setImage(with: NSURL.init(string:oldStr)as! URL, for: .normal)
                    imageBack.addSubview(btn)
                    btn.addTarget(self, action: #selector(ContentImageCLick(_:)), for: .touchUpInside)
                    
                    
                }
                
            }
           
        }else{
            imageBackTop.constant=0
            imageBackHeight.constant=0
        }
        if model.replay.count>0{
            replyTop.constant=15;
            replyHeight.constant=30;
            var replyStr = (model.replay.object(at: 0) as!NSDictionary).object(forKey: "replycontent") as!String
            if replyStr.isEmpty {
                replyStr="[图片]"
            }
            replyButton.setTitle(replyStr, for: .normal)
            var count = model.replay.count
            count=count>3 ? 3:count
            for i in 0 ..< count {
                let dic = model.replay[i] as!NSDictionary
                let userImg = UIImageView()
                userImg.frame=CGRect.init(x: CGFloat(i)*CGFloat(35), y: 0, width: 30, height: 30)
                userImg.sd_setImage(with: NSURL.init(string: dic.object(forKey: "headurl") as!String) as URL!, placeholderImage: UIImage.init(named: "guagua")!)
                alluser .addSubview(userImg)
                let user = UIButton.init(type: .custom)
                user.frame=userImg.frame
                user.isEnabled=false
                user.adjustsImageWhenDisabled=false
                if Int(dic.object(forKey: "sex")as!String)==0 {
                    user.setBackgroundImage(UIImage.init(named: "蓝色"), for: .normal)
                }else{
                    user.setBackgroundImage(UIImage.init(named: "红色"), for: .normal)
                }
                alluser.addSubview(user)
                
                
            }
        }else{
            replyButton.setTitle("", for: .normal)
            replyTop.constant=0;
            replyHeight.constant=0;
            for (_,value) in alluser.subviews.enumerated() {
                value.removeFromSuperview()
            }
        }
        print("--zan--\(model.titlePraiseNum)----reply--\(model.titlereply)")
        zan.setTitle(String.init(format: " %@", model.titlePraiseNum), for: .normal)
        replyNum.setTitle(String.init(format: " %@", model.titlereply), for: .normal)
    }
    func ContentImageCLick(_ sender:UIButton) {
        print("------sender.tag----\(sender.tag)")
        delegate?.didClickImageTagWithModel(sender.tag, model: _model)
    }
    func compareCurrentTime(time:String) -> String {
        let formatter=DateFormatter.init()
        formatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        let compareDate = formatter.date(from: time)
        var timeInterval = compareDate?.timeIntervalSinceNow
        timeInterval = -timeInterval!
        let temp=timeInterval!/60
        var resutl=NSString()
        if temp<1 {
            resutl="刚刚"
        }else if temp<60{
            resutl=NSString.init(format: "%.0f分钟前", temp)
        }else if temp/60<24{
            resutl=NSString.init(format: "%.0f小时前", temp/60)
        }else if temp/60/24<7{
           resutl = NSString.init(format: "%.0f天前", temp/60/24)
        }else{
            let timeStr=NSString.init(string: time)
            let Arr = timeStr.components(separatedBy: " ")
            let str=NSString.init(string: Arr[0])
            resutl=str.substring(from: 2) as NSString
        }
        return resutl as String
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
