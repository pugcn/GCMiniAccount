//
//  TypeCollectionReusableView.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/19.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class TypeCollectionReusableView: UICollectionReusableView {
    var titleImgView = UIImageView()
    var titleLabel = UILabel()
    var countlabel = UILabel()
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
        self.addSubview(titleImgView)
        titleImgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.left.mas_equalTo()(10)
            make.height.mas_equalTo()(34)
            make.width.mas_equalTo()(34)
        }
        self.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.left.mas_equalTo()(titleImgView.mas_right)?.setOffset(10)
        }
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        
        self.addSubview(countlabel)
        countlabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self)
            make.right.mas_equalTo()(-12)
        }
        countlabel.textColor = UIColor.lightGray
        countlabel.font = UIFont.systemFont(ofSize: 12)
    }
    // 根据model 填充Cell
    func cellForModel(model: AddPayModel?){
        if let tempModel = model {
            
            titleImgView.image = UIImage(named:tempModel.picName)
            titleLabel.text = tempModel.title
            countlabel.text = "\(tempModel.detailArr.count)"
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
