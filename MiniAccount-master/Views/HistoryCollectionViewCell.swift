//
//  HistoryCollectionViewCell.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/18.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    var titlePic = UIImageView()
    var titleLabel = UILabel()
    var remarkeLabel = UILabel()
    var timeLabel = UILabel()
    var moneyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titlePic)
        titlePic.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self.contentView)
            make.left.mas_equalTo()(20)
            make.height.mas_equalTo()(30)
            make.width.mas_equalTo()(30)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.mas_equalTo()(15)
            make.left.mas_equalTo()(titlePic.mas_right)?.setOffset(15)
        }
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.black
        
        self.contentView.addSubview(timeLabel)
        timeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.mas_equalTo()(-10)
            make.left.mas_equalTo()(titleLabel.mas_left)
        }
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = UIColor.darkGray
        self.contentView.addSubview(remarkeLabel)
        remarkeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.mas_equalTo()(-10)
            make.left.mas_equalTo()(timeLabel.mas_right)?.setOffset(8)
        }
        remarkeLabel.font = UIFont.systemFont(ofSize: 10)
        remarkeLabel.textColor = UIColor.darkGray
        
        
        self.contentView.addSubview(moneyLabel)
        moneyLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self.contentView)
            make.right.mas_equalTo()(-16)
        }
        moneyLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 根据model 填充Cell
    func cellForModel(model: BillModel?){
        if let tempModel = model {
            
            titleLabel.text = tempModel.typeName
            if tempModel.picName != nil{
                titlePic.image = UIImage(named:tempModel.picName)
            }
            let money = String(format:"%.2f",tempModel.money)
            if let time = tempModel.theTime{
                let timeArr = time.components(separatedBy: "-")
                let timestr = "\(timeArr[1])月\(timeArr[2])日"
                timeLabel.text = timestr
            }
            moneyLabel.text = "¥ \(money)"
            if let remarke = tempModel.remarke{
                
                remarkeLabel.text = remarke
                
            }
            else{
                remarkeLabel.text = "无"
            }
            if tempModel.isPay == true{
                moneyLabel.textColor = UIColor.red
            }
            else{
                moneyLabel.textColor = UIColor.green
            }
            
        }
        
    }
}
