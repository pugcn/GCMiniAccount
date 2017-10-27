//
//  AddDetailCollectionViewCell.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/14.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class AddDetailCollectionViewCell: UICollectionViewCell {
    var detailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(detailLabel)
        detailLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.mas_equalTo()(self.contentView)
            make.height.mas_equalTo()(self.contentView.frame.size.height-10)
            make.width.mas_equalTo()(self.contentView.frame.size.width-4)
        }
        detailLabel.textAlignment = NSTextAlignment.center
        detailLabel.backgroundColor = bgGrayColor
        detailLabel.clipsToBounds = true
        detailLabel.layer.cornerRadius = 4
        detailLabel.textColor = UIColor.black
        detailLabel.font = UIFont.systemFont(ofSize: 10)
    }
    // 根据model 填充Cell
    func cellForModel(model: DetailType?){
        if let tempModel = model {
            detailLabel.text = tempModel.detailName
            if tempModel.isSelected == true{
                detailLabel.backgroundColor = bgDarkColor
                detailLabel.textColor = UIColor.white
            }
            else{
                detailLabel.backgroundColor = bgGrayColor
                detailLabel.textColor = UIColor.black
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
