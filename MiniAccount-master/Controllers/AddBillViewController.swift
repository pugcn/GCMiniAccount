//
//  AddBillViewController.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/12.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var collectionView : UICollectionView?
    var topImgView = UIImageView()
    var topLabel = UILabel()
    var lab = UILabel()
    var topTextFiled = UITextField()
    var segment = UISegmentedControl()
    var segmentimgPay = UIImageView()
    var segmentimgIcoume = UIImageView()
    var addPayArr = [AddPayModel]()
     var saveBtn = UIButton()
    var addpay = AddPayModel()
    var detailarr = [String]()
    var sectionState = [Bool]() // section 状态-记录 false 关 true 开
    var bgView = UIView()
    var bottonView = UIView()
    var datePicker = UIDatePicker()
    var theTime : String?
    var newBill = BillModel()
    var detailType = [DetailType]()
    var detail = DetailType()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = bgColor
        // Do any additional setup after loading the view.
        createNavigationSubview()
        createCollectionView()
        createDatePicekr()
        addPayArr = AddPayModel.getPayArray(addpay)()
        addPayArr.removeLast()
        self.detailarr = (addPayArr.first?.detailArr)!
        
        detailarr.forEach { (name) in
            sectionState.append(false) //默认是关闭状态
            detail.detailName = name
            detail.isSelected = false
            detailType.append(detail)
        }
       
    }
    
    //设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    @objc func tapGesture(tap:UITapGestureRecognizer){
        let point = tap.location(in: self.view)
        if point.y < KHeight-bottonView.frame.size.height && bottonView.alpha == 1 {
            
                bottonView.alpha = 0
                saveBtn.alpha = 1
                bgView.isHidden = true
            
            
        }
    }
    func createNavigationSubview()  {
        let view_navi = UIView(frame:CGRect(x:0,y:0,width:KWidth,height:64))
        self.view.addSubview(view_navi)
        view_navi.backgroundColor = bgBlackColor
        let label_title = UILabel(frame:CGRect(x:0,y:20,width:KWidth,height:44))
        view_navi.addSubview(label_title)
        label_title.text = "手动记账"
        label_title.font = UIFont.systemFont(ofSize: 16)
        label_title.textAlignment = .center
        label_title.textColor = UIColor.white
        
        let leftBtn = UIButton(frame:CGRect(x:12,y:25,width:40,height:40))
        self.view.addSubview(leftBtn)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named:"back_arrow_write"), for: .normal)
        leftBtn.addTarget(self, action:#selector(backAction), for: .touchUpInside)
        
        let topView = UIView()
        self.view.addSubview(topView)
        topView.backgroundColor = UIColor.white
        topView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(64)
            make.left.mas_equalTo()(self.view)
            make.right.mas_equalTo()(self.view)
            make.height.mas_equalTo()(64)
        }
        topView.layer.borderWidth = 0.3
        topView.layer.borderColor = UIColor.gray.cgColor
        
        topView.addSubview(topImgView)
        topImgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(topView)
            make.left.mas_equalTo()(12)
            make.height.mas_equalTo()(34)
            make.width.mas_equalTo()(34)
        }
        
        topView.addSubview(topLabel)
        topLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(topView)
            make.left.mas_equalTo()(topImgView.mas_right)?.setOffset(8)
        }
        topLabel.font = UIFont.systemFont(ofSize: 12)
        topLabel.textColor = UIColor.darkGray
        
        topView.addSubview(topTextFiled)
        topTextFiled.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(topView)
            make.right.mas_equalTo()(-12)
        }
        topTextFiled.delegate = self
        topTextFiled.layer.borderColor = UIColor.clear.cgColor
        topTextFiled.placeholder = "0.00"
        topTextFiled.textColor = UIColor.red
       topTextFiled.setValue(UIColor.red, forKeyPath: "_placeholderLabel.textColor")
        topTextFiled.addTarget(self, action: #selector(topTextChange(sender:)), for: .editingChanged)
        
        topView.addSubview(lab)
        lab.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(topTextFiled.mas_left)?.setOffset(-6)
            make.centerY.mas_equalTo()(topView)
        }
        lab.text = "¥"
        lab.textColor = UIColor.red
        
        segment = UISegmentedControl.init(items: ["支出","收入"])
        self.view.addSubview(segment)
        segment.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(self.view)
            make.top.mas_equalTo()(topView.mas_bottom)
            make.right.mas_equalTo()(self.view)
            make.height.mas_equalTo()(48)
        }
        segment.backgroundColor = bgColor
        segment.tintColor = UIColor.white
        segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.gray], for: UIControlState.normal)
        
        segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.red], for: UIControlState.selected)
        
        
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentAction), for:UIControlEvents.valueChanged )
        
        self.view.addSubview(segmentimgPay)
        self.view.addSubview(segmentimgIcoume)
        segmentimgPay.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(self.view)
            make.width.mas_equalTo()(KWidth/2)
            make.height.mas_equalTo()(4)
            make.top.mas_equalTo()(segment.mas_bottom)
        }
        segmentimgIcoume.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(self.view)
            make.top.mas_equalTo()(segment.mas_bottom)
            make.width.mas_equalTo()(KWidth/2)
            make.height.mas_equalTo()(4)
        }
        
        segmentimgPay.image = UIImage(named:"pay_underline")
        
        segmentimgIcoume.image = UIImage(named:"income_underline")
        segmentimgIcoume.isHidden = true
        
    }
    
    @objc func topTextChange(sender:UITextField){
        if sender.text != ""
        {
        saveBtn.isEnabled = true
        saveBtn.backgroundColor = btnColor
        saveBtn.setTitleColor(UIColor.white, for: .normal)
        }
        else{
            saveBtn.isEnabled = false
            saveBtn.backgroundColor = bgGrayColor
            saveBtn.setTitleColor(UIColor.darkGray, for: .normal)
        }
    }
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func segmentAction(sender:UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            segmentimgPay.isHidden = false
            segmentimgIcoume.isHidden = true
            segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.red], for: UIControlState.selected)
             lab.textColor = UIColor.red
            topTextFiled.setValue(UIColor.red, forKeyPath: "_placeholderLabel.textColor")
            topTextFiled.text = ""
            topTextFiled.textColor = UIColor.red
            addPayArr.removeAll()
            detailarr.removeAll()
            
            addPayArr = AddPayModel.getPayArray(addpay)()
            self.detailarr = (addPayArr.first?.detailArr)!
            detailarr.forEach { (name) in
                sectionState.append(false) //默认是关闭状态
                detail.detailName = name
                detail.isSelected = false
                detailType.append(detail)
            }
            addPayArr.removeLast()
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            
        default:
            segmentimgIcoume.isHidden = false
            segmentimgPay.isHidden = true
            segment.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.green], for: UIControlState.selected)
             lab.textColor = UIColor.green
            topTextFiled.setValue(UIColor.green, forKeyPath: "_placeholderLabel.textColor")
            topTextFiled.text = ""
            topTextFiled.textColor = UIColor.green
            addPayArr.removeAll()
            detailType.removeAll()
            detailarr.removeAll()
            addPayArr = AddPayModel.getIncoumeArray(addpay)()

            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        
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
        
        theTime = formatter.string(from: today as Date)
        
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
    
    
    @objc func time_cancleAction(){
        bottonView.alpha = 0
        saveBtn.alpha = 1
        bgView.isHidden = true
    }
    
    @objc func time_okAction(){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        theTime = formatter.string(from: datePicker.date)
        self.collectionView?.reloadSections(NSIndexSet(index: 2) as IndexSet)
        bottonView.alpha = 0
        saveBtn.alpha = 1
        bgView.isHidden = true
    }
    
    //textfiled delegate
    
    func createCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x:0,y:180,width:KWidth,height:KHeight-226), collectionViewLayout: layout)
        self.view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(AddBillCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView?.register(AddDetailCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "detailcell")
        collectionView?.register(AddBillCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView?.backgroundColor = bgColor
        
       
        self.view.addSubview(saveBtn)
        saveBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(60)
            make.right.mas_equalTo()(-60)
            make.bottom.mas_equalTo()(-4)
            make.height.mas_equalTo()(40)
        }
        saveBtn.isEnabled = false
        saveBtn.backgroundColor = bgGrayColor
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(UIColor.darkGray, for: .normal)
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        saveBtn.layer.cornerRadius = 10
    }
    
    @objc func saveAction(){
        if let name = topLabel.text{
            
            newBill.typeName = name
            newBill.picName = homeImgDict[name]
        }
        
      
        if let money = Double(topTextFiled.text!){
            newBill.money = money
        }
        if let time = theTime{
            newBill.theTime = time
            let timeArr = time.components(separatedBy: "-")
            newBill.mounth = timeArr[1]
            newBill.year = timeArr[0]
        }
        if segment.selectedSegmentIndex == 0 {
            newBill.isPay = true
        }
        else{
            newBill.isPay = false
            newBill.typeName = "收入"
            newBill.picName = homeImgDict["收入"]
        }
        newBill.bg_save()
         self.dismiss(animated: true, completion: nil)
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section==0) {
            return self.addPayArr.count
        }
        
        else if (section == 1) {
            return sectionState[section] == true ? self.detailType.count : 0
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddBillCollectionViewCell
            
            
            cell.cellForModel(model: self.addPayArr[indexPath.row])
            self.addPayArr[indexPath.row].isSelected = false
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailcell", for: indexPath) as! AddDetailCollectionViewCell
        cell.cellForModel(model: self.detailType[indexPath.row])
        self.detailType[indexPath.row].isSelected = false
        return cell
       
    }
    //cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let cellx = ((self.collectionView?.frame.size.width)! - 6.0 * 15)/5.0
            return CGSize(width: cellx, height: cellx+10)
        }
        let cellx = ((self.collectionView?.frame.size.width)! - 6 * 10)/5.0
        return CGSize(width: cellx, height: cellx/2.6+10)
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
           return CGSize(width: KWidth, height: 0)
        }
        return CGSize(width: KWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView = AddBillCollectionReusableView()
        if kind == UICollectionElementKindSectionHeader{
            
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! AddBillCollectionReusableView
            headerView.backgroundColor = UIColor.white
            headerView.sectionBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            headerView.sectionBtn.tag = indexPath.section
            headerView.showImgView.image = sectionState[indexPath.section] ? UIImage(named:"manual_more_open") : UIImage(named:"manual_more")
            if indexPath.section == 1{
                headerView.headLabel.text = "细分分类"
                headerView.timeLabel.isHidden = true
                headerView.remarkeTextFiled.isHidden = true
                headerView.showImgView.isHidden = false
                headerView.headImgView.image = UIImage(named:"manual_sort")
            }
            else if indexPath.section == 2 {
                headerView.headLabel.text = "时间"
                headerView.timeLabel.text = theTime
                 headerView.headImgView.image = UIImage(named:"time")
                headerView.showImgView.isHidden = true
                headerView.remarkeTextFiled.isHidden = true
                headerView.timeLabel.isHidden = false
                
            }
            else{
                headerView.headLabel.text = "备注"
                headerView.sectionBtn.isHidden = true
                headerView.headImgView.image = UIImage(named:"remark")
                headerView.showImgView.isHidden = true
                headerView.timeLabel.isHidden = true
                headerView.remarkeTextFiled.isHidden = false
                headerView.remarkeTextFiled.addTarget(self, action: #selector(remarkeSelected(sender:)), for: .editingChanged)
            }
           
        }
        return headerView
        
    }
    
    @objc func remarkeSelected(sender:UITextField){
        newBill.remarke = sender.text
    }
    
   @objc func buttonClick(sender: UIButton) {
    if sender.tag == 1{
        sectionState[sender.tag] = sectionState[sender.tag] == true ? false : true
        collectionView?.reloadSections(NSIndexSet(index: sender.tag) as IndexSet)
    }
    if sender.tag == 2 {
            bottonView.alpha = 1
            saveBtn.alpha = 0
            bgView.isHidden = false
        
    }
    }
    
    
    //返回 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if section == 0 {
           return UIEdgeInsetsMake(6, 10, 6, 10)
        }
        else if section == 1 && segment.selectedSegmentIndex == 0 && sectionState[1] == true{
            return UIEdgeInsetsMake(6, 10, 6, 10)
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section==0 {
            let path = UIBezierPath()
            let cell = collectionView.cellForItem(at: indexPath) as! AddBillCollectionViewCell
            path.move(to: cell.titleimgView.center)
            let cellRect = collectionView.convert(cell.frame, to: collectionView)
            let imgInCellRect = cell.titleimgView.frame
            let x = cellRect.origin.x + imgInCellRect.origin.x
            let y = cellRect.origin.y + imgInCellRect.origin.y + 180
            let imgRect = CGRect(x:x, y:y, width:imgInCellRect.size.width, height:imgInCellRect.size.height)
            
            let animateImage = UIImageView.init(frame: imgRect)
            animateImage.image = cell.titleimgView.image
            self.view.addSubview(animateImage)
            let imagePoint = CGPoint(x:12+topImgView.size.width/2,y:96)
            path.move(to: animateImage.center)
            path.addCurve(to: imagePoint, controlPoint1: CGPoint(x:animateImage.frame.origin.x,y:animateImage.frame.origin.y+100), controlPoint2: CGPoint(x:animateImage.frame.origin.x,y:animateImage.frame.origin.y+100))
            let imgAnmiation = CAKeyframeAnimation.init(keyPath: "position")
            imgAnmiation.path = path.cgPath
            imgAnmiation.duration = 1
            imgAnmiation.isRemovedOnCompletion = false
            imgAnmiation.fillMode = kCAFillModeForwards
            animateImage.layer.add(imgAnmiation, forKey: nil)
            let model = self.addPayArr[indexPath.row]
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
                animateImage.removeFromSuperview()
                self.topImgView.image = UIImage(named:model.imgName)
                self.topLabel.text = model.title
            })
            
            
            self.detailarr.removeAll()
            self.detailType.removeAll()
          
            model.isSelected = true
            
            
            if ((self.addPayArr[indexPath.row].detailArr) != nil) {
            self.detailarr = self.addPayArr[indexPath.row].detailArr
                detailarr.forEach { (name) in
                    sectionState.append(false) //默认是关闭状态
                    detail.detailName = name
                    detail.isSelected = false
                    detailType.append(detail)
                }
            
        }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        else{
           self.detailType[indexPath.row].isSelected = true
            newBill.detailType = self.detailType[indexPath.row].detailName
            DispatchQueue.main.async {
                collectionView.reloadSections(NSIndexSet(index: 1) as IndexSet)
            }
        }
        
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
