//
//  AddBillCollectionViewCell.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/14.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class AddBillCollectionViewCell: UICollectionViewCell {
    var titleimgView = UIImageView()
    var titleLabel = UILabel()
    var bgView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(titleimgView)
        titleimgView.mas_makeConstraints({ (make:MASConstraintMaker!) in
            make.centerX.mas_equalTo()(self.contentView)
            make.top.mas_equalTo()(6)
            make.height.mas_equalTo()(34)
            make.width.mas_equalTo()(34)
        })
        titleimgView.addSubview(bgView)
        bgView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.left.mas_equalTo()(titleimgView)
            make.right.mas_equalTo()(titleimgView)
            make.top.mas_equalTo()(titleimgView)
            make.bottom.mas_equalTo()(titleimgView)
        }
        bgView.layer.cornerRadius = 17
        bgView.backgroundColor = UIColor.clear
        self.contentView.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerX.mas_equalTo()(self.contentView)
            make.top.mas_equalTo()(titleimgView.mas_bottom)?.setOffset(4)
        }
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textColor = UIColor.black
    }
    

    // 根据model 填充Cell
    func cellForModel(model: AddPayModel?){
        if let tempModel = model {
            titleimgView.image = UIImage(named:tempModel.imgName!)
            titleLabel.text = tempModel.title
            if model?.isSelected == true{
                bgView.backgroundColor = UIColor.black
                bgView.alpha = 0.5
            }
            else{
                bgView.backgroundColor = UIColor.clear
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
