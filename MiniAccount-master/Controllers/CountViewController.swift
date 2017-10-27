//
//  CountViewController.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/12.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit


class CountViewController: UIViewController {

    var chartView = CustomPieView()
    
    var segmentDataArray = [Int]()
    
    var segmentTitleArray = [String]()
    
    var segmentColorArray = [Any]()
    
    var leftTitle = UILabel()
    var leftNum = UILabel()
    var rightTitle = UILabel()
    var rightNum = UILabel()
    var leftLine = UIImageView()
    var rightLine = UIImageView()
    var yearArray = [Array<BillModel>]()
    var chartWidth : CGFloat?
    
    var segment = UISegmentedControl()
    var choseBtn = UIButton()
    var chartHeight: CGFloat?
    var flag : Bool?
    var payNum = Double()
    var Icoume = Double()
    var itemCount = Int()
    
    var menuArray = [Dictionary<String, Any>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        loadPieData()
        createNavigationSubview()
        self.flag = true
        itemCount = 0
        weak var weakSelf = self
        CommonMenuView.createMenu(withFrame: CGRect.zero, target: self, dataArray: menuArray, itemsClick: { (str, tag) in
            weakSelf?.doSomething(str: str!, tag: tag)
        }) {
            weakSelf?.flag = true
        }
        
        loadPieChartView()
    }
    func loadPieData(){
        chartWidth = KWidth-20
        
        chartHeight = 300
        var arr = BillModel.bg_findAll() as! [BillModel]
        
        var i = 0
        while (i<arr.count) {
            var tempArray = [BillModel]()
            tempArray.append(arr[i])
            let stri = arr[i].year
            var j = i+1
            while (j<arr.count){
                let strj = arr[j].year
                if stri == strj {
                    tempArray.append(arr[j])
                    arr.remove(at: j)
                    j -= 1
                }
                j += 1
            }
            yearArray.append(tempArray)
            i += 1
        }
        yearArray.forEach { (bil) in
            let dict = ["imageName":"icon_button_recall",
                         "itemName":"\(bil[0].year!)年"]
            menuArray.append(dict)
        }
        
        var x = 0
        var billarr = yearArray[itemCount]
        payNum = 0
        Icoume = 0
        while (x<(billarr.count)){
                var tempArray = [BillModel]()
            let theBill = billarr[x]
            if theBill.isPay == true{
                payNum += theBill.money
            }
            else{
                Icoume += theBill.money
            }
            tempArray.append(billarr[x])
            let stri = billarr[x].typeName
                var j = x+1
            while (j<(billarr.count)){
                let strj = billarr[j].typeName
                    if stri == strj {
                        tempArray.append(billarr[j])
                        billarr.remove(at: j)
                        j -= 1
                    }
                    j += 1
                }
                segmentDataArray.append(tempArray.count)
                segmentTitleArray.append((tempArray.first?.typeName)!)
                x += 1
            }
       
        self.view.backgroundColor = UIColor.white
    }
    
    func doSomething(str:String,tag:Int){
        var x = 0
        while (x<(yearArray.count)) {
            if x == tag-1{
                itemCount = x
                segmentTitleArray.removeAll()
                segmentDataArray.removeAll()
                menuArray.removeAll()
                loadPieData()
                chartView.segmentDataArray = segmentDataArray
                chartView.segmentTitleArray = segmentTitleArray
                chartView.update()
                choseBtn.setTitle(menuArray[x]["itemName"] as? String, for: .normal)
                leftNum.text = "\(String(format: "%.2f", payNum))"
                rightNum.text = "\(String(format: "%.2f", Icoume))"
            }
            x += 1
        }
        CommonMenuView.hidden()
        self.flag = true
    }
    
    func loadPieChartView(){
        //包含文本的视图frame
        chartView = CustomPieView.init(frame: CGRect(x:10,y:164,width:chartWidth!,height:chartHeight!))
        
        //数据源
        chartView.segmentDataArray = segmentDataArray
        
        
        //标题，若不传入，则为“其他”
        chartView.segmentTitleArray = segmentTitleArray
        
        //动画时间
        chartView.animateTime = 2.0
        
        //内圆的颜色
        chartView.innerColor = UIColor.white
        
        //内圆的半径
        chartView.innerCircleR = 10
        
        //大圆的半径
        chartView.pieRadius = 60
        
        //整体饼状图的背景色
        chartView.backgroundColor = UIColor.init(red: 240.0/255.0, green: 241.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
        //圆心位置，此属性会被centerXPosition、centerYPosition覆盖，圆心优先使用centerXPosition、centerYPosition
        chartView.centerType = .topMiddle
        
        //是否动画
        chartView.needAnimation = true
        
        //动画类型，全部只有一个动画；各个部分都有动画
        chartView.type = .together
        
        //圆心，相对于饼状图的位置
        chartView.centerXPosition = 70
        
        //右侧的文本颜色是否等同于模块的颜色
        chartView.isSameColor = false
        
        //文本的行间距
        chartView.textSpace = 20
        
        //文本的字号
        chartView.textFontSize = 12
        
        //文本的高度
        chartView.textHeight = 30
        
        //文本前的颜色块的高度
        chartView.colorHeight = 10
        
        //文本前的颜色块是否为圆
        chartView.isRound = true
        
        //文本距离右侧的间距
        chartView.textRightSpace = 20
        
        //支持点击事件
        chartView.canClick = true
        
        //点击圆饼后的偏移量
        chartView.clickOffsetSpace = 10
        
        //不隐藏右侧的文本
        chartView.hideText = false
        
        //点击触发的block，index与数据源对应
        chartView.click { (index) in
            print("点击了\(index)")
        }
        
        //添加到视图上
        chartView.showCustomView(inSuperView: self.view)
    }
    //设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
   
    func createNavigationSubview()  {
        let view_navi = UIView(frame:CGRect(x:0,y:0,width:KWidth,height:64))
        self.view.addSubview(view_navi)
        view_navi.backgroundColor = bgBlackColor
        let label_title = UILabel(frame:CGRect(x:0,y:20,width:KWidth,height:44))
        view_navi.addSubview(label_title)
        label_title.text = "统计"
        label_title.font = UIFont.systemFont(ofSize: 16)
        label_title.textAlignment = .center
        label_title.textColor = UIColor.white
        
        let leftBtn = UIButton(frame:CGRect(x:12,y:25,width:40,height:40))
        self.view.addSubview(leftBtn)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named:"back_arrow_write"), for: .normal)
        leftBtn.addTarget(self, action:#selector(backAction), for: .touchUpInside)
        
        let topView = UIView.init(frame: CGRect(x:0,y:64,width:KWidth,height:50))
        self.view.addSubview(topView)
        self.view.addSubview(choseBtn)
        
        choseBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.mas_equalTo()(topView)
        }
        choseBtn.setTitle("2017年", for: .normal)
        choseBtn.setTitleColor(btnColor, for: .normal)
        choseBtn.addTarget(self, action: #selector(choseAction), for: .touchUpInside)
        choseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        let choseView = UIView.init(frame: CGRect(x:10,y:114,width:KWidth-20,height:50))
        self.view.addSubview(choseView)
        choseView.backgroundColor = UIColor.init(red: 240.0/255.0, green: 241.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
        choseView.addSubview(leftTitle)
        leftTitle.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(choseView)?.setOffset(-6)
            make.left.mas_equalTo()(KWidth/4)
        }
        leftTitle.text = "年支出"
        leftTitle.textColor = UIColor.black
        leftTitle.font = UIFont.systemFont(ofSize: 10)
        
        choseView.addSubview(leftNum)
        leftNum.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(choseView)?.setOffset(10)
            make.left.mas_equalTo()(KWidth/4)
        }
       
        leftNum.textColor = UIColor.red
        leftNum.font = UIFont.systemFont(ofSize: 10)
        
        choseView.addSubview(rightTitle)
        rightTitle.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(choseView)?.setOffset(-6)
            make.right.mas_equalTo()(-KWidth/4)
        }
        rightTitle.text = "年收入"
        rightTitle.textColor = UIColor.black
        rightTitle.font = UIFont.systemFont(ofSize: 10)
        
        choseView.addSubview(rightNum)
        rightNum.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(choseView)?.setOffset(10)
            make.right.mas_equalTo()(-KWidth/4)
        }
         leftNum.text = "\(String(format: "%.2f", payNum))"
        rightNum.text = "\(String(format: "%.2f", Icoume))"
        rightNum.textColor = UIColor.green
        rightNum.font = UIFont.systemFont(ofSize: 10)
      
        
    }
    @objc func choseAction(){
        popMenu(point: CGPoint(x:KWidth/2+10,y:110))
    }
    
    func popMenu(point:CGPoint){
    if flag != nil {
    CommonMenuView.showMenu(at: point)
    self.flag = false
    }else{
    CommonMenuView.hidden()
    self.flag = true
    }
    }
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
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
