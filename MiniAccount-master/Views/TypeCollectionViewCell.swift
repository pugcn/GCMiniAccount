//
//  TypeCollectionViewCell.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/19.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.center.mas_equalTo()(self.contentView)
        }
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
