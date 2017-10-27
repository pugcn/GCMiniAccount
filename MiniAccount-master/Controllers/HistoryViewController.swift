//
//  HistoryViewController.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/17.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var collectionView : UICollectionView?
    var headerArray = [HistoryHeader]()
    var dataArray = [Array<BillModel>]()
    var sectionState = [Bool]() // section 状态-记录 false 关 true 开
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        createNavigationSubview()
        createCollectionVew()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataArray.removeAll()
        self.headerArray.removeAll()
        requestData()
        self.collectionView?.reloadData()
    }
    //设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    func requestData(){
        var arr = BillModel.bg_findAll() as! [BillModel]
        var yearArray = [Array<BillModel>]()
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
        var harr = [Array<BillModel>]()
        yearArray.forEach { (billArr) in
            var x = 0
            var billarr = billArr
            while (x<billarr.count){
                var tempArray = [BillModel]()
                tempArray.append(billarr[x])
                let stri = billarr[x].mounth
                var j = x+1
                while (j<billarr.count){
                    let strj = billarr[j].mounth
                    if stri == strj {
                        tempArray.append(billarr[j])
                        billarr.remove(at: j)
                        j -= 1
                    }
                    j += 1
                }
                harr.append(tempArray)
                x += 1
            }
        }
        self.dataArray = harr
        harr.forEach { (heArr) in
            var pay = 0.00
            var icoume = 0.00
            var header = HistoryHeader()
            heArr.forEach({ (hbill) in
                if hbill.isPay == true{
                    pay += hbill.money
                }
                else{
                    icoume += hbill.money
                }
            })
            header.mounth = heArr.first?.mounth
            header.year = heArr.first?.year
            header.icoume = icoume
            header.pay = pay
            self.headerArray.append(header)
        }
        self.dataArray.forEach { _ in
            sectionState.append(false) //默认是关闭状态
        }
    }
    
    func createNavigationSubview()  {
        let view_navi = UIView(frame:CGRect(x:0,y:0,width:KWidth,height:64))
        self.view.addSubview(view_navi)
        view_navi.backgroundColor = bgBlackColor
        let label_title = UILabel(frame:CGRect(x:0,y:20,width:KWidth,height:44))
        view_navi.addSubview(label_title)
        label_title.text = "历史账单"
        label_title.font = UIFont.systemFont(ofSize: 16)
        label_title.textAlignment = .center
        label_title.textColor = UIColor.white
        let leftBtn = UIButton(frame:CGRect(x:12,y:25,width:40,height:40))
        self.view.addSubview(leftBtn)
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setImage(UIImage(named:"back_arrow_write"), for: .normal)
        leftBtn.addTarget(self, action:#selector(backAction), for: .touchUpInside)
        
    }
    
    @objc func backAction(){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func createCollectionVew(){
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x:0,y:64,width:KWidth,height:KHeight-64), collectionViewLayout: layout)
        self.view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(HistoryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView?.register(HistoryCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView?.backgroundColor = UIColor.white
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return sectionState[section] == true ? self.dataArray[section].count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HistoryCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.cellForModel(model: self.dataArray[indexPath.section][indexPath.row])
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.1
        
        return cell
    }
    
    //cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: KWidth, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: KWidth, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView = HistoryCollectionReusableView()
        if kind == UICollectionElementKindSectionHeader{
            
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! HistoryCollectionReusableView
            headerView.cellForModel(model: headerArray[indexPath.section])
            headerView.backgroundColor = UIColor.white
            headerView.layer.borderWidth = 0.2
            headerView.layer.borderColor = UIColor.darkGray.cgColor
            headerView.sectionBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            headerView.sectionBtn.tag = indexPath.section
            headerView.isOpenImgView.image = sectionState[indexPath.section] ? UIImage(named:"open_arrow") : UIImage(named:"close_arrow")
        }
        return headerView
        
    }
    
    @objc func buttonClick(sender: UIButton) {
            sectionState[sender.tag] = sectionState[sender.tag] == true ? false : true
            collectionView?.reloadSections(NSIndexSet(index: sender.tag) as IndexSet)
    }
    
    //返回 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dvc = BillDetailViewController()
        dvc.theBill = self.dataArray[indexPath.section][indexPath.row]
        dvc.modalTransitionStyle = .flipHorizontal
        self.present(dvc, animated: true, completion: nil)
        
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
