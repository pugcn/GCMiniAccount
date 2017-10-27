//
//  AddBillCollectionReusableView.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/14.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class AddBillCollectionReusableView: UICollectionReusableView {
    var headImgView = UIImageView()
    var headLabel = UILabel()
    var timeLabel = UILabel()
    var showImgView = UIImageView()
    var remarkeTextFiled = UITextField()
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
        self.addSubview(headImgView)
        headImgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.left.mas_equalTo()(10)
            make.height.mas_equalTo()(20)
            make.width.mas_equalTo()(20)
        }
        self.addSubview(headLabel)
        headLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.left.mas_equalTo()(headImgView.mas_right)?.setOffset(8)
        }
        headLabel.font = UIFont.systemFont(ofSize: 12)
        headLabel.textColor = UIColor.black
        
        self.addSubview(showImgView)
        showImgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.right.mas_equalTo()(-10)
            make.width.mas_equalTo()(18)
            make.height.mas_equalTo()(18)
        }
        
        self.addSubview(timeLabel)
        timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.right.mas_equalTo()(-10)
        }
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.black
        
        self.addSubview(remarkeTextFiled)
        remarkeTextFiled.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.right.mas_equalTo()(-10)
            make.width.mas_equalTo()(120)
        }
        remarkeTextFiled.font = UIFont.systemFont(ofSize: 12)
        remarkeTextFiled.textAlignment = NSTextAlignment.right
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
