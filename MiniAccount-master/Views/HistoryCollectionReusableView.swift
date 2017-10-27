//
//  HistoryCollectionReusableView.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/18.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class HistoryCollectionReusableView: UICollectionReusableView {
    
    var isOpenImgView = UIImageView()
    var mounthLabel = UILabel()
    var yearLabel = UILabel()
    var icoumeLabel = UILabel()
    var payLabel = UILabel()
    var sectionBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sectionBtn)
        sectionBtn.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(self)
            make.right.mas_equalTo()(self)
            make.top.mas_equalTo()(self)
            make.bottom.mas_equalTo()(self)
        }
        sectionBtn.backgroundColor = UIColor.clear
        self.addSubview(isOpenImgView)
        isOpenImgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(8)
            make.centerY.mas_equalTo()(self)
            make.height.mas_equalTo()(20)
            make.width.mas_equalTo()(20)
        }
        self.addSubview(mounthLabel)
        mounthLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(isOpenImgView.mas_right)?.setOffset(10)
            make.centerY.mas_equalTo()(self)?.setOffset(-6)
        }
        mounthLabel.font = UIFont.systemFont(ofSize: 13)
        mounthLabel.textColor = UIColor.black
        
        self.addSubview(yearLabel)
        yearLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(isOpenImgView.mas_right)?.setOffset(10)
            make.top.mas_equalTo()(mounthLabel.mas_bottom)?.setOffset(8)
        }
        yearLabel.textColor = UIColor.gray
        yearLabel.font = UIFont.systemFont(ofSize: 10)
        
        let labIco = UILabel()
        self.addSubview(labIco)
        labIco.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(-140)
            make.centerY.mas_equalTo()(self)?.setOffset(-6)
        }
        labIco.textColor = UIColor.black
        labIco.font = UIFont.systemFont(ofSize: 13)
        labIco.text = "收入"
        
        let labPay = UILabel()
        self.addSubview(labPay)
        labPay.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.right.mas_equalTo()(-60)
            make.centerY.mas_equalTo()(self)?.setOffset(-6)
        }
        labPay.textColor = UIColor.black
        labPay.font = UIFont.systemFont(ofSize: 13)
        labPay.text = "支出"
        
        self.addSubview(icoumeLabel)
        icoumeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(labIco.mas_bottom)?.setOffset(8)
            make.centerX.mas_equalTo()(labIco)
        }
        icoumeLabel.textColor = UIColor.green
        icoumeLabel.font = UIFont.systemFont(ofSize: 10)
        icoumeLabel.text = "￥12.00"
        
        self.addSubview(payLabel)
        payLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
           make.top.mas_equalTo()(labPay.mas_bottom)?.setOffset(8)
            make.centerX.mas_equalTo()(labPay)
        }
        payLabel.textColor = UIColor.red
        payLabel.font = UIFont.systemFont(ofSize: 10)
        payLabel.text = "￥12.00"
        
    }
    // 根据model 填充视图
    func cellForModel(model:HistoryHeader?){
        if let tempModel = model {
            mounthLabel.text = "\(tempModel.mounth!)月"
            yearLabel.text = "\(tempModel.year!)年"
            payLabel.text = "￥\(String(format: "%.2f", tempModel.pay!))"
            icoumeLabel.text = "￥\(String(format: "%.2f", tempModel.icoume!))"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
