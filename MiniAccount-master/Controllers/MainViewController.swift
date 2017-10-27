//
//  MainViewController.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/8.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tableView = UITableView()
    var view_navi = UIView()
    var dataArray = [BillModel]()
    var imgView = UIImageView()
    var label_incomeNum = UILabel()
    var label_payNum = UILabel()
    var label_dayIcome = UILabel()
    var label_dayPay = UILabel()
    var todayPay = 0.00
    var todayIcoume = 0.00
    var mounthPay = 0.00
    var mounthIcoume = 0.00
    override func viewDidLoad() {
        super.viewDidLoad()
        bg_setDebug(true)
        view.backgroundColor = UIColor.white
        createNavigationSubview()
        createButtonAction()
        creatDayView()
        createTableView()
        
    }
    
    //设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataArray.removeAll()
        let bill = BillModel()
        bill.typeName = "建表"
        bill.bg_save()
        BillModel.bg_deleteWhere(["typeName","=","建表"])
        let arr = BillModel.bg_findAll() as! [BillModel]
        let today = NSDate()
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        mounthPay = 0.00
        mounthIcoume = 0.00
        todayPay = 0.00
        todayIcoume = 0.00
        let theTime = formatter.string(from: today as Date)
        let timeArr = theTime.components(separatedBy: "-")
        arr.forEach { (bill) in
            if theTime == bill.theTime{
                dataArray.append(bill)
                if bill.isPay == true{
                    todayPay += bill.money
                }
                else{
                    todayIcoume += bill.money
                }
            }
            let btimeArr = bill.theTime.components(separatedBy: "-")
            if timeArr[1] == btimeArr[1]{
                if bill.isPay == true{
                    mounthPay += bill.money
                }
                else{
                    mounthIcoume += bill.money
                }
            }
            
        }
        label_dayPay.text = "\(String(format:"%.2f",todayPay))"
        label_dayIcome.text = "\(String(format:"%.2f",todayIcoume))"
        label_payNum.text = "\(String(format:"%.2f",mounthPay))"
        label_incomeNum.text = "\(String(format:"%.2f",mounthIcoume))"
        if dataArray.count>0 {
            dataArray = dataArray.reversed()
            imgView.isHidden = true
            self.tableView.reloadData()
        }
        else{
            imgView.isHidden  = false
        }
    }
    //MARK:创建头部导航栏视图
    func createNavigationSubview()  {
        view_navi = UIView(frame:CGRect(x:0,y:0,width:KWidth,height:200))
        self.view.addSubview(view_navi)
        //        view_navi.backgroundColor = UIColor.init(red: 43.0/255.0, green: 43.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        let bgview = UIImageView()
        view_navi.addSubview(bgview)
        bgview.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(view_navi)
            make.left.equalTo()(view_navi)
            make.bottom.equalTo()(view_navi)
            make.right.equalTo()(view_navi)
        }
        bgview.image = UIImage(named:"home_bg")
        //title
        let label_title = UILabel(frame:CGRect(x:0,y:20,width:KWidth,height:44))
        view_navi.addSubview(label_title)
        label_title.text = "Mini记账"
        label_title.font = UIFont.systemFont(ofSize: 16)
        label_title.textAlignment = .center
        label_title.textColor = UIColor.white
        
        let label_income = UILabel()
        view_navi.addSubview(label_income)
        label_income.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(20)
            make.top.mas_equalTo()(label_title.mas_bottom)?.setOffset(20)
        }
        label_income.text = "本月收入"
        label_income.font = UIFont.systemFont(ofSize: 16)
        label_income.textColor = UIColor.white
        
        
        view_navi.addSubview(label_incomeNum)
        label_incomeNum.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(20)
            make.top.mas_equalTo()(label_income.mas_bottom)?.setOffset(20)
        }
        label_incomeNum.font = UIFont.systemFont(ofSize: 22)
        label_incomeNum.textColor = UIColor.white
        
        let label_pay = UILabel()
        view_navi.addSubview(label_pay)
        label_pay.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(20)
            make.top.mas_equalTo()(label_incomeNum.mas_bottom)?.setOffset(20)
        }
        label_pay.text = "本月支出"
        label_pay.font = UIFont.systemFont(ofSize: 13)
        label_pay.textColor = UIColor.white
        
        
        view_navi.addSubview(label_payNum)
        label_payNum.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(label_pay.mas_right)?.setOffset(10)
            make.top.mas_equalTo()(label_incomeNum.mas_bottom)?.setOffset(20)
        }
        label_payNum.font = UIFont.systemFont(ofSize: 13)
        label_payNum.textColor = UIColor.white
        
        let label_budget = UILabel()
        view_navi.addSubview(label_budget)
        label_budget.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(KWidth/2+20)
            make.top.mas_equalTo()(label_incomeNum.mas_bottom)?.setOffset(20)
        }
        label_budget.text = "剩余预算"
        label_budget.font = UIFont.systemFont(ofSize: 13)
        label_budget.textColor = UIColor.white
        
        let label_budgetNum = UILabel()
        view_navi.addSubview(label_budgetNum)
        label_budgetNum.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(label_budget.mas_right)?.setOffset(10)
            make.top.mas_equalTo()(label_incomeNum.mas_bottom)?.setOffset(20)
        }
        label_budgetNum.text = "3000.00"
        label_budgetNum.font = UIFont.systemFont(ofSize: 13)
        label_budgetNum.textColor = UIColor.white
        
    }
    
    //MARK:创建button
    func createButtonAction()  {
        let leftBtn = UIButton(frame:CGRect(x:12,y:25,width:40,height:40))
        self.view.addSubview(leftBtn)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named:"home_menu"), for: .normal)
        leftBtn.addTarget(self, action:#selector(openDrawer), for: .touchUpInside)
        
        let rightBtn = UIButton(frame:CGRect(x:KWidth-40,y:25,width:40,height:40))
        self.view.addSubview(rightBtn)
        rightBtn.backgroundColor = UIColor.clear
        rightBtn.setImage(UIImage(named:"home_right"), for: .normal)
        rightBtn.addTarget(self, action: #selector(openCount), for: .touchUpInside)
    }
    
    @objc func openCount(){
        let vc = CountViewController()
        let animation = CATransition()
        
        animation.duration = 0.5    //  时间
        
        /**  type：动画类型
         *  pageCurl       向上翻一页
         *  pageUnCurl     向下翻一页
         *  rippleEffect   水滴
         *  suckEffect     收缩
         *  cube           方块
         *  oglFlip        上下翻转
         */
        animation.type = "cube";
        
        /**  type：页面转换类型
         *  kCATransitionFade       淡出
         *  kCATransitionMoveIn     覆盖
         *  kCATransitionReveal     底部显示
         *  kCATransitionPush       推出
         */
        
        
        //PS：type 更多效果请 搜索： CATransition
        
        /**  subtype：出现的方向
         *  kCATransitionFromRight       右
         *  kCATransitionFromLeft        左
         *  kCATransitionFromTop         上
         *  kCATransitionFromBottom      下
         */
        animation.subtype = kCATransitionFromRight
        
        self.view.window?.layer.add(animation, forKey: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK:创建今日收支视图
    func creatDayView(){
        let dayView = UIView()
        self.view.addSubview(dayView)
        dayView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(self.view)
            make.top.mas_equalTo()(view_navi.mas_bottom)
            make.height.mas_equalTo()(44)
            make.width.mas_equalTo()(KWidth)
        }
        dayView.layer.borderWidth=0.5
        dayView.layer.borderColor=UIColor.lightGray.cgColor
        
        let label_day = UILabel()
        dayView.addSubview(label_day)
        label_day.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.mas_equalTo()(dayView)
            make.top.mas_equalTo()(8)
        }
        label_day.font = UIFont.systemFont(ofSize: 11)
        label_day.text = "今日收支"
        label_day.textColor = UIColor.black
        
        let label_center = UILabel()
        dayView.addSubview(label_center)
        label_center.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.mas_equalTo()(dayView)
            make.top.mas_equalTo()(label_day.mas_bottom)?.setOffset(0.5)
        }
        label_center.text = "|"
        label_center.textColor = UIColor.black
        
        
        dayView.addSubview(label_dayIcome)
        label_dayIcome.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(label_center.mas_left)?.setOffset(-8)
            make.centerY.mas_equalTo()(label_center)
        }
        label_dayIcome.textColor = UIColor.green
        label_dayIcome.font = UIFont.systemFont(ofSize: 11)
        
        
        dayView.addSubview(label_dayPay)
        label_dayPay.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(label_center.mas_right)?.setOffset(8)
            make.centerY.mas_equalTo()(label_center)
        }
        label_dayPay.textColor = UIColor.red
        label_dayPay.font = UIFont.systemFont(ofSize: 11)
    }
    func createTableView(){
        self.view.addSubview(tableView)
        tableView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(view_navi.mas_bottom)?.setOffset(44)
            make.left.mas_equalTo()(self.view)
            make.width.mas_equalTo()(KWidth)
            make.bottom.mas_equalTo()(self.view.mas_bottom)?.setOffset(-44)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        view.addSubview(imgView)
        imgView.mas_makeConstraints({ (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(view_navi.mas_bottom)?.setOffset(44)
            make.left.mas_equalTo()(self.view)
            make.width.mas_equalTo()(KWidth)
            make.bottom.mas_equalTo()(self.view.mas_bottom)?.setOffset(-44)
        })
        imgView.image = UIImage(named:"home_no")
        let bottomView = UIView()
        self.view .addSubview(bottomView)
        bottomView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(4)
            make.height.mas_equalTo()(44)
            make.right.mas_equalTo()(-4)
            make.bottom.mas_equalTo()(self.view)
        }
        bottomView.backgroundColor = btnColor
        bottomView.layer.cornerRadius = 8
        
        let accountBtn = UIButton()
        bottomView.addSubview(accountBtn)
        accountBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(8)
            make.height.mas_equalTo()(44)
            make.width.mas_equalTo()(120)
            make.bottom.mas_equalTo()(self.view)
        }
        accountBtn.setTitle("记一笔", for:.normal)
        accountBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        accountBtn.titleLabel?.textColor = UIColor.white
        accountBtn.addTarget(self, action: #selector(addBillAction), for: .touchUpInside)
        
        let fenLabel = UILabel()
        bottomView.addSubview(fenLabel)
        fenLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(accountBtn.mas_right)?.setOffset(4)
            make.height.mas_equalTo()(44)
            make.width.mas_equalTo()(10)
            make.top.mas_equalTo()(bottomView)
        }
        fenLabel.text = "|"
        fenLabel.textColor = UIColor.white
        
        let historyBtn = UIButton()
        bottomView.addSubview(historyBtn)
        historyBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(fenLabel.mas_right)?.setOffset(4)
            make.height.mas_equalTo()(44)
            make.bottom.mas_equalTo()(bottomView)
            make.width.mas_equalTo()(KWidth-164)
        }
        historyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        historyBtn.setTitle("历史账单", for: .normal)
        historyBtn.titleLabel?.textColor = UIColor.white
        historyBtn.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        label_dayPay.text = "\(String(format:"%.2f",todayPay))"
        label_dayIcome.text = "\(String(format:"%.2f",todayIcoume))"
        label_payNum.text = "\(String(format:"%.2f",mounthPay))"
        label_incomeNum.text = "\(String(format:"%.2f",mounthIcoume))"
        
    }
    @objc func addBillAction(){
        let avc = AddBillViewController()
        avc.modalTransitionStyle = .coverVertical
        self.present(avc, animated: true, completion: nil)
    }
    
    @objc func historyAction(){
        let hvc = HistoryViewController()
        hvc.modalTransitionStyle = .crossDissolve
        self.present(hvc, animated: true, completion: nil)
    }
    
    //Mark tableViewDelegate && tableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellID(), for: indexPath) as! HomeTableViewCell
        
        cell.cellForModel(model: dataArray[indexPath.row])
        return cell
    }
    
    //在这里修改删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    //点击删除按钮的响应方法，在这里处理删除的逻辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            BillModel.bg_deleteWhere(["bg_id","=",dataArray[indexPath.row].bg_id])
            dataArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            if dataArray.count == 0{
                imgView.isHidden = false
            }
        }
    }
    
    //返回cell高度 （高度固定时，不用这样写）
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.cellHeight()
    }
    /// 打开抽屉效果
    @objc func openDrawer(){
        ManagerViewController.sharedViewController.openDrawer(openDrawerWithDuration: 0.2)
    }
    
    
    /// 遮罩按钮手势的回调
    ///
    /// - parameter pan: 手势
    @objc  func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        ManagerViewController.sharedViewController.panGestureRecognizer(pan: pan)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detVc = BillDetailViewController()
        detVc.theBill = self.dataArray[indexPath.row]
        detVc.modalTransitionStyle = .flipHorizontal
        self.present(detVc, animated: true, completion: nil)
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
