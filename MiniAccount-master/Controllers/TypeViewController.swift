//
//  TypeViewController.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/19.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit
protocol SendDelegate {
    func typeName(title:String,detail:String)
}
class TypeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var delegate : SendDelegate?
    var collectionView : UICollectionView?
    var headerArray = [AddPayModel]()
    var addpay = AddPayModel()
    var dataArry = [Array<String>]()
    var sectionState = [Bool]() // section 状态-记录 false 关 true 开
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        createNavigationSubview()
        headerArray = AddPayModel.getPayArray(addpay)()
        headerArray.forEach { (type) in
            dataArry.append(type.detailArr)
        }
        dataArry.forEach { _ in
            sectionState.append(false)
        }
        createCollectionView()
        
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
        label_title.text = "收支分类"
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
    
    func createCollectionView(){
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x:0,y:64,width:KWidth,height:KHeight-64), collectionViewLayout: layout)
        self.view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(TypeCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView?.register(TypeCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView?.backgroundColor = bgColor
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return headerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionState[section] == true ? self.dataArry[section].count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TypeCollectionViewCell
        cell.backgroundColor = UIColor.gray
        cell.titleLabel.text = self.dataArry[indexPath.section][indexPath.row]
        cell.layer.cornerRadius = 6
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView = TypeCollectionReusableView()
        if kind == UICollectionElementKindSectionHeader{
            
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "headerView", for: indexPath) as! TypeCollectionReusableView
            headerView.cellForModel(model: headerArray[indexPath.section])
            headerView.backgroundColor = bgColor
            headerView.layer.borderWidth = 0.4
            headerView.layer.borderColor = UIColor.darkGray.cgColor
            headerView.sectionBtn.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            headerView.sectionBtn.tag = indexPath.section
        }
        return headerView
        
    }
    
    @objc func buttonClick(sender: UIButton) {
        sectionState[sender.tag] = sectionState[sender.tag] == true ? false : true
        collectionView?.reloadSections(NSIndexSet(index: sender.tag) as IndexSet)
    }
    
    //返回 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if sectionState[section] == true {
            return UIEdgeInsetsMake(10, 10, 10, 10)
        }
        else{
        return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.typeName(title: headerArray[indexPath.section].title, detail: dataArry[indexPath.section][indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    //cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellx = ((self.collectionView?.frame.size.width)! - 6 * 10)/5.0
        return CGSize(width: cellx, height: cellx/2.6)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: KWidth, height: 46)
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
