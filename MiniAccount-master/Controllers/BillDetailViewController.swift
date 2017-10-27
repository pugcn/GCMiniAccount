//
//  BillDetailViewController.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/18.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class BillDetailViewController: UIViewController,SendDelegate {
    
    var theBill : BillModel?
    var lab2Right = UILabel()
    var topTextFiled = UITextField()
    var btn4Right = UIButton()
    var titlelabel = UILabel()
    var theTime : String?
    var bgView = UIView()
    var bottonView = UIView()
    var datePicker = UIDatePicker()
    var saveBtn = UIButton()
    var btn3Right = UIButton()
    var txt5Right = UITextField()
     var titleImgView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        createNavigationSubview()
        createUI()
        createDatePicekr()
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
        label_title.text = "账单详情"
        label_title.font = UIFont.systemFont(ofSize: 16)
        label_title.textAlignment = .center
        label_title.textColor = UIColor.white
        
        let leftBtn = UIButton(frame:CGRect(x:12,y:25,width:40,height:40))
        self.view.addSubview(leftBtn)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named:"back_arrow_write"), for: .normal)
        leftBtn.addTarget(self, action:#selector(backAction), for: .touchUpInside)
        
        let rightBtn = UIButton(frame:CGRect(x:KWidth-52,y:25,width:40,height:40))
        self.view.addSubview(rightBtn)
        rightBtn.backgroundColor = UIColor.clear
        rightBtn.setImage(UIImage(named:"delete_detail2x"), for: .normal)
        rightBtn.addTarget(self, action:#selector(deleteAction), for: .touchUpInside)
        
    }
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func deleteAction(){
        BillModel.bg_deleteWhere(["bg_id","=",theBill?.bg_id as Any])
        self.dismiss(animated: true, completion: nil)
    }
    
    func createUI(){
        let topView = UIView()
        self.view.addSubview(topView)
        topView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(6)
            make.top.mas_equalTo()(70)
            make.right.mas_equalTo()(-6)
            make.height.mas_equalTo()(60)
        }
        topView.layer.cornerRadius = 6
        topView.layer.borderWidth = 0.4
        topView.layer.borderColor = UIColor.gray.cgColor
        let imgBgView = UIView()
        topView.addSubview(imgBgView)
        imgBgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(topView)
            make.top.mas_equalTo()(topView)
            make.bottom.mas_equalTo()(topView)
            make.width.mas_equalTo()(60)
        }
        imgBgView.backgroundColor = bgBlackColor
        imgBgView.layer.cornerRadius = 6
       
        imgBgView.addSubview(titleImgView)
        titleImgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.mas_equalTo()(imgBgView)
            make.width.mas_equalTo()(34)
            make.height.mas_equalTo()(34)
        }
        titleImgView.image = UIImage(named:(theBill?.picName)!)
        
        
        topView.addSubview(titlelabel)
        titlelabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(topView)
            make.left.mas_equalTo()(imgBgView.mas_right)?.setOffset(8)
        }
        titlelabel.textColor = UIColor.darkGray
        titlelabel.font = UIFont.systemFont(ofSize: 13)
        titlelabel.text = theBill?.typeName
        
        
        topView.addSubview(topTextFiled)
        topTextFiled.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(topView)
            make.right.mas_equalTo()(-10)
        }
        if let money = theBill?.money{
            topTextFiled.text = "\(money)"
        }
        topTextFiled.addTarget(self, action: #selector(moneyAction(sender:)), for: .editingChanged)
        
        let centerView = UIView()
        self.view.addSubview(centerView)
        centerView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(topView.mas_bottom)?.setOffset(8)
            make.left.mas_equalTo()(6)
            make.right.mas_equalTo()(-6)
            make.height.mas_equalTo()(250)
        }
        let centerview1 = UIView.init(frame: CGRect(x:0,y:0,width:KWidth-12,height:50))
        let centerview2 = UIView.init(frame: CGRect(x:0,y:50,width:KWidth-12,height:50))
        let centerview3 = UIView.init(frame: CGRect(x:0,y:100,width:KWidth-12,height:50))
        let centerview4 = UIView.init(frame: CGRect(x:0,y:150,width:KWidth-12,height:50))
        let centerview5 = UIView.init(frame: CGRect(x:0,y:200,width:KWidth-12,height:50))
        centerView.addSubview(centerview1)
        centerView.addSubview(centerview2)
        centerView.addSubview(centerview3)
        centerView.addSubview(centerview4)
        centerView.addSubview(centerview5)
        centerView.layer.cornerRadius = 8
        centerView.layer.borderWidth = 0.3
        centerView.layer.borderColor = UIColor.darkGray.cgColor
        centerview2.layer.borderWidth = 0.3
        centerview2.layer.borderColor = UIColor.darkGray.cgColor
        centerview3.layer.borderWidth = 0.3
        centerview3.layer.borderColor = UIColor.darkGray.cgColor
        centerview4.layer.borderWidth = 0.4
        centerview4.layer.borderColor = UIColor.darkGray.cgColor
        
        let lab1 = UILabel()
        centerview1.addSubview(lab1)
        lab1.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview1)
            make.left.mas_equalTo()(12)
        }
        lab1.text = "明细"
        lab1.textColor = UIColor.darkGray
        lab1.font = UIFont.systemFont(ofSize: 13)
        
        let img2View = UIImageView()
        centerview2.addSubview(img2View)
        img2View.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview2)
            make.left.mas_equalTo()(10)
            make.width.mas_equalTo()(24)
            make.height.mas_equalTo()(24)
        }
        let lab2Left = UILabel()
        centerview2.addSubview(lab2Left)
        lab2Left.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview2)
            make.left.mas_equalTo()(img2View.mas_right)?.setOffset(10)
        }
        lab2Left.textColor = UIColor.lightGray
        lab2Left.font = UIFont.systemFont(ofSize: 13)
        lab2Left.text = "账单金额"
        
        centerview2.addSubview(lab2Right)
        lab2Right.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview2)
            make.right.mas_equalTo()(-10)
        }
        lab2Right.textColor = UIColor.black
        lab2Right.font = UIFont.systemFont(ofSize: 13)
        if let money = theBill?.money {
            lab2Right.text = "\(money)"
        }
        
        let img3View = UIImageView()
        centerview3.addSubview(img3View)
        img3View.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview3)
            make.left.mas_equalTo()(10)
            make.width.mas_equalTo()(24)
            make.height.mas_equalTo()(24)
        }
        let lab3Left = UILabel()
        centerview3.addSubview(lab3Left)
        lab3Left.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview3)
            make.left.mas_equalTo()(img3View.mas_right)?.setOffset(10)
        }
        lab3Left.textColor = UIColor.lightGray
        lab3Left.font = UIFont.systemFont(ofSize: 13)
        lab3Left.text = "记录时间"
        
        centerview3.addSubview(btn3Right)
        btn3Right.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview3)
            make.right.mas_equalTo()(-10)
        }
        btn3Right.setTitle(theBill?.theTime, for: .normal)
        btn3Right.setTitleColor(UIColor.black, for: .normal)
        btn3Right.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        let img4View = UIImageView()
        centerview4.addSubview(img4View)
        img4View.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview4)
            make.left.mas_equalTo()(10)
            make.width.mas_equalTo()(24)
            make.height.mas_equalTo()(24)
        }
        let lab4Left = UILabel()
        centerview4.addSubview(lab4Left)
        lab4Left.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview4)
            make.left.mas_equalTo()(img4View.mas_right)?.setOffset(10)
        }
        lab4Left.textColor = UIColor.lightGray
        lab4Left.font = UIFont.systemFont(ofSize: 13)
        lab4Left.text = "账单类别"
       
        centerview4.addSubview(btn4Right)
        btn4Right.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview4)
            make.right.mas_equalTo()(-10)
        }
        if let title = theBill?.typeName {
            btn4Right.setTitle(title, for: .normal)
            if let detail = theBill?.detailType{
                    btn4Right.setTitle("\(title)-\(detail)", for: .normal)
            }
            
        }
        
        btn4Right.setTitleColor(UIColor.black, for: .normal)
        btn4Right.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn3Right.addTarget(self, action: #selector(timeAction), for: .touchUpInside)
        btn4Right.addTarget(self, action: #selector(typeAction), for: .touchUpInside)
        let img5View = UIImageView()
        centerview5.addSubview(img5View)
        img5View.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview5)
            make.left.mas_equalTo()(10)
            make.width.mas_equalTo()(24)
            make.height.mas_equalTo()(24)
        }
        let lab5Left = UILabel()
        centerview5.addSubview(lab5Left)
        lab5Left.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview5)
            make.left.mas_equalTo()(img5View.mas_right)?.setOffset(10)
        }
        lab5Left.textColor = UIColor.lightGray
        lab5Left.font = UIFont.systemFont(ofSize: 13)
        lab5Left.text = "账单备注"
       
        centerview5.addSubview(txt5Right)
        txt5Right.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(centerview5)
            make.right.mas_equalTo()(-10)
        }
        
        
        self.view.addSubview(saveBtn)
        saveBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(centerView.mas_bottom)?.setOffset(12)
            make.left.mas_equalTo()(6)
            make.right.mas_equalTo()(-6)
            make.height.mas_equalTo()(46)
        }
        saveBtn.setTitleColor(UIColor.black, for: .normal)
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.addTarget(self, action: #selector(saveAction(sender:)), for: .touchUpInside)
        saveBtn.layer.cornerRadius = 8
        saveBtn.layer.borderWidth = 0.3
        saveBtn.layer.borderColor = UIColor.darkGray.cgColor
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        img2View.image = UIImage(named:"money_detail2x")
        img3View.image = UIImage(named:"details_icon_time")
        img4View.image = UIImage(named:"details_icon_note")
        img5View.image = UIImage(named:"details_icon_label")
    }
    
    func createDatePicekr(){
        self.view.addSubview(bottonView)
        bottonView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(view)
            make.right.mas_equalTo()(view)
            make.bottom.mas_equalTo()(view)
            make.height.mas_equalTo()(164)
        }
        
        bottonView.backgroundColor = UIColor.white
        bottonView.alpha = 0
        
        self.bottonView.addSubview(datePicker)
        datePicker.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(bottonView)
            make.right.mas_equalTo()(bottonView)
            make.bottom.mas_equalTo()(bottonView)
            make.height.mas_equalTo()(130)
        }
        datePicker.layer.borderWidth = 0.5
        datePicker.layer.borderColor = UIColor.darkGray.cgColor
        datePicker.locale = Locale(identifier: "zh_CN")
        let today = NSDate()
        datePicker.setDate(today as Date, animated: true)
        datePicker.datePickerMode = .date
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        let time_cacleBtn = UIButton()
        let time_okBtn = UIButton()
        bottonView.addSubview(time_cacleBtn)
        bottonView.addSubview(time_okBtn)
        time_cacleBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(18)
            make.top.mas_equalTo()(6)
        }
        time_cacleBtn.addTarget(self, action: #selector(time_cancleAction), for: .touchUpInside)
        
        time_cacleBtn.setTitle("取消", for: .normal)
        time_cacleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        time_cacleBtn.setTitleColor(UIColor.black, for: .normal)
        time_okBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(-18)
            make.top.mas_equalTo()(6)
        }
        time_okBtn.setTitle("确定", for: .normal)
        time_okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        time_okBtn.setTitleColor(UIColor.black, for: .normal)
        time_okBtn.addTarget(self, action: #selector(time_okAction), for: .touchUpInside)
        
        self.view.addSubview(bgView)
        bgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(self.view)
            make.right.mas_equalTo()(self.view)
            make.bottom.mas_equalTo()(bottonView.mas_top)
            make.top.mas_equalTo()(self.view)
        }
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.1
        
        bgView.isHidden = true
        //添加手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGesture(tap:)))
        
        bgView .addGestureRecognizer(tap)
        
    }
    
    func typeName(title: String, detail: String) {
    
        btn4Right.setTitle("\(title)-\(detail)", for: .normal)
        titleImgView.image = UIImage(named:homeImgDict[title]!)
        titlelabel.text = title
        theBill?.typeName = title
        theBill?.detailType = detail
        if title == "收入" {
            theBill?.isPay = true
        }
    }
    
    @objc func moneyAction(sender:UITextField){
        lab2Right.text = sender.text
    }
    @objc func typeAction(){
        let tvc = TypeViewController()
        tvc.modalTransitionStyle = .crossDissolve
        tvc.delegate = self
        self.present(tvc, animated: true, completion: nil)
    }
    
    @objc func timeAction(){
        bottonView.alpha = 1
        bgView.isHidden = false
    }
    
    @objc func tapGesture(tap:UITapGestureRecognizer){
        let point = tap.location(in: self.view)
        if point.y < KHeight-bottonView.frame.size.height && bottonView.alpha == 1 {
            
            bottonView.alpha = 0
            bgView.isHidden = true
            
            
        }
    }
    @objc func time_cancleAction(){
        bottonView.alpha = 0
        bgView.isHidden = true
    }
    
    @objc func time_okAction(){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        theTime = formatter.string(from: datePicker.date)
        btn3Right.setTitle(theTime, for: .normal)
        bottonView.alpha = 0
        bgView.isHidden = true
    }
    
    
    @objc func saveAction(sender:UIButton){
        if let name = titlelabel.text{
            theBill?.typeName = name
            theBill?.picName = homeImgDict[name]
        }
        if let money = Double(topTextFiled.text!){
            theBill?.money = money
        }
        if let time = theTime{
            theBill?.theTime = time
            let timeArr = time.components(separatedBy: "-")
            theBill?.mounth = timeArr[1]
            theBill?.year = timeArr[0]
        }
    
            theBill?.remarke = txt5Right.text
        theBill?.bg_updateWhere(["bg_id","=",theBill?.bg_id as Any])
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
