//
//  ViewControllerOne.swift
//  ChengguaSwift
//
//  Created by jarvis on 2016/11/29.
//  Copyright © 2016年 jarvis jiangjjw. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import SwiftDefine
import SDWebImage
import MWPhotoBrowser
class ViewControllerOne: UIViewController,UITableViewDelegate,UITableViewDataSource,ChengguaCellDelegate,MWPhotoBrowserDelegate {
    
    var num : NSNumber = 0.0
    let userID:String = "100044365"
    let token:String = "196890753d7cb1cfe3eb37b324ce428a"
    
    var guaTable = UITableView()
    var pageNum : Int = 1
    let listArray:NSMutableArray = NSMutableArray.init()
    let CellHeights = NSMutableArray()
    var selectedArrs = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "bgImg1991"), for: .default)
        self.navigationItem.title="123"
        self.navigationController?.navigationBar.barTintColor=UIColor.white
        if num==0 {
           print("heheda----")
        }else{
           print("error---+++")
        }
        initTable()
//        print("----swift\()")
        loadData(page: pageNum,refresh: true)
        print("----screen----\(SwiftDefine.screenWidth())")
        // Do any additional setup after loading the view.
    }
    
    

    func initTable() {
    
        guaTable=UITableView.init(frame: CGRect.zero, style: .plain)
       guaTable.frame=CGRect.init(x: 0, y: 0, width: Define.screenWidth(), height: Define.screenHeight()-49)
        guaTable.delegate=self
        guaTable.dataSource=self
        guaTable.mj_header=MJRefreshNormalHeader.init(refreshingBlock: { 
            self.pageNum=1
            self.loadData(page: self.pageNum,refresh: true)
        })

        guaTable.mj_footer=MJRefreshAutoNormalFooter.init(refreshingBlock: {
                       self.pageNum+=1
                        self.loadData(page: self.pageNum,refresh: false)
        })
       
    
        
    
//        guaTable.rowHeight=44;
//        guaTable.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        guaTable.register(UINib.init(nibName: "ChenggguaCell", bundle:Bundle.main), forCellReuseIdentifier: "cell")
        self.view.addSubview(guaTable)
        
    }
    func loadData(page: Int,refresh :Bool)  {
    
        let url:String = String.init(format: "http://chenggua.com/api.php?r=topic/topichomepage&userid=%@&pagenum=%d&token=%@&flag=%d&labelid=%d", userID,page,token,0,0)
        print("---url----\(url)")
       
        Alamofire.request( url , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            switch response.result{
            case.success:
                if refresh{
                    self.listArray .removeAllObjects()
                    self.CellHeights.removeAllObjects()
                }
self.guaTable.mj_footer.endRefreshing()
self.guaTable.mj_header.endRefreshing()
//                if page==3{
//                    self.guaTable.mj_footer.endRefreshingWithNoMoreData()
//                    return
//                }
                    print("success------\(response)")
                    if let json:NSDictionary = response.result.value as? NSDictionary{
                        let result=json.value(forKey: "result") as!NSDictionary
                        let topics = result.object(forKey: "topic") as!NSArray
                        for dic in topics{
                            let model=TopicModel()
                            model.setValuesForKeys(dic as! [String : Any])
                            self.listArray.add(model)
                            let height=self.cacluateCellHeight(model: model)
                            self.CellHeights.add(height)
                        }
                        self.guaTable.reloadData()
//                        print("-\(json)")

                    }
                
            case.failure(let error):
                print(" error------|\(error)--");
            }
            
        }
//        Alamofire.request("", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
    }
    //MARK:  UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellHeights.object(at: indexPath.row) as! CGFloat
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
     //MARK:  UITableViewDelegate?,dataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChenggguaCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!ChenggguaCell
//        let model:TopicModel=listArray.object(at: indexPath.row) as! TopicModel
//       cell.textLabel?.text=model.title
////        let imageData = NSData.init(contentsOf: NSURL.init(string: model.headurl) as! URL)
//        cell.imageView?.sd_setImage(with: NSURL.init(string: model.headurl) as! URL)
////        cell.imageView?.image=UIImage.init(data: imageData as! Data)
        let model = listArray.object(at: indexPath.row)
        cell.ConfigWithModel(model: model as!TopicModel)
        cell.delegate = self
        return cell
    }
    func cacluateCellHeight(model:TopicModel) -> CGFloat {
        let height = CGFloat(52)
        if model.isreward.intValue==1 {
            model.title=String.init(format: "    %@", model.title)
        }
        let titleStr = NSString.init(string: model.title)
        let paragraph = NSMutableParagraphStyle.init()
        paragraph.lineSpacing=5
        let attStr = NSMutableAttributedString.init(string: model.title)
        attStr.addAttributes([NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:UIFont.init(name: "HiraginoSansGB-W3", size: 17) as Any], range: NSRange.init(location: 0, length: attStr.length))
//        print("titleStr-----\(titleStr)")
        var titleHeight = getStrSize(str: titleStr, font: UIFont.init(name: "HiraginoSans-W3", size: 17)!, lineSpace: 5, size: CGSize.init(width: SwiftDefine.screenWidth()-24, height: CGFloat(MAXFLOAT))).height
        print("---titleHeight----\(titleHeight)")
        if titleHeight<20 {
            titleHeight=20
        }else if titleHeight>40{
            titleHeight=40+8
        }
        var contentHeight = getStrSize(str: model.topiccontent as NSString, font:UIFont.init(name: "HiraginoSans-W3", size: 15)! , lineSpace: 5, size: CGSize.init(width: SwiftDefine.screenWidth()-CGFloat(24), height: CGFloat(MAXFLOAT))).height
        print("-------contentheight----\(contentHeight)")
        if contentHeight<20 {
            contentHeight=20.0
        }else if contentHeight>40{
            contentHeight=40+5.0
        }
        var imageHeight = CGFloat(0)
        if model.topicImg.count>0 {
            if model.topicImg.count==1 {
                let ImgScale = ((SwiftDefine.screenWidth()-CGFloat(100))*2/3+CGFloat(10))/200
                if model.imgwidth.floatValue != 0 && model.imgHeight.floatValue != 0 && CGFloat(model.imgwidth.floatValue/model.imgHeight.floatValue)>ImgScale {
                    imageHeight=((SwiftDefine.screenWidth()-CGFloat(100))*2/3+CGFloat(10))/CGFloat(model.imgwidth.floatValue/model.imgHeight.floatValue)+CGFloat(8)
                }else{
                    imageHeight=CGFloat(208)
                }
                
            }else{
                imageHeight=(SwiftDefine.screenWidth()-100)/3+CGFloat(8)
            }
        }
        var replyHeight = CGFloat(0)
        var lastHeight=CGFloat(0)
        if model.replay.count>0 {
            lastHeight=CGFloat(10+30)
            replyHeight=CGFloat(10)+(SwiftDefine.screenWidth()-24.0)*11/130
        }else{
            lastHeight=CGFloat(10.0+20.0)
        }
        let totalHeight = height+CGFloat(10)+titleHeight+CGFloat(8)+contentHeight+imageHeight+lastHeight+replyHeight+CGFloat(10)
        
        return totalHeight
        
    }
   
    //MARK: ChengguaCellDelegate
    func didClickImageTagWithModel(_ tag:Int,model:TopicModel)
    {
        selectedArrs.removeAllObjects()
        print("----imgTag---\(tag)---model:--\(model.topicImg)")
//         let photos = NSMutableArray()
        for i in 0 ..< model.topicImg.count{
            let photo = MWPhoto.init(url: NSURL.init(string: model.topicImg[i] as! String) as URL!)
            selectedArrs.add(photo!)
        }
        let browser = MWPhotoBrowser.init(delegate: self)
        browser?.setCurrentPhotoIndex(UInt(tag))
        self.navigationController?.pushViewController(browser!, animated: true)
    }
    //MARK: MWPhotoBrowserDelegate
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt
    {
        return UInt(selectedArrs.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol!
    {
        let Index_int=Int(index)
        let photo = selectedArrs.object(at: Index_int) as!MWPhoto
        if Index_int<selectedArrs.count{
            return photo
        }else{
            return nil
        }
        
    }
    func getStrSize(str:NSString,font:UIFont,lineSpace:CGFloat,size:CGSize) -> CGSize {
        let attStr = NSMutableAttributedString.init(string: str as String)
        let paraGraph = NSMutableParagraphStyle()
        paraGraph.lineSpacing=5
         attStr.addAttributes([NSParagraphStyleAttributeName:paraGraph,NSFontAttributeName:font], range: NSMakeRange(0, attStr.length))
        let mySize = attStr.boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading], context: nil).size
       
        
        return mySize
        
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
