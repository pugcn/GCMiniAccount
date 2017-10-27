//
//  HomeTableViewCell.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/11.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    var titlePic = UIImageView()
    var titleLabel = UILabel()
    var remarkeLabel = UILabel()
    var moneyLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: HomeTableViewCell.cellID())
        self.contentView.addSubview(titlePic)
        titlePic.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self.contentView)
            make.left.mas_equalTo()(15)
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
        
        self.contentView.addSubview(remarkeLabel)
        remarkeLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.bottom.mas_equalTo()(-10)
            make.left.mas_equalTo()(titleLabel.mas_left)
        }
        remarkeLabel.font = UIFont.systemFont(ofSize: 10)
        remarkeLabel.textColor = UIColor.darkGray
        
        self.contentView.addSubview(moneyLabel)
        moneyLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.centerY.mas_equalTo()(self.contentView)
            make.right.mas_equalTo()(-10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //类方法：重用标识符
    class func cellID () -> String {
        return "cell"
    }
    // 类方法 返回高度
    class func cellHeight() -> CGFloat {
        
        return 60
    }
    
    // 根据model 填充Cell
    func cellForModel(model: BillModel?){
        if let tempModel = model {
            
            titleLabel.text = tempModel.typeName
            if tempModel.picName != nil{
            titlePic.image = UIImage(named:tempModel.picName)
            }
            let money = String(format:"%.2f",tempModel.money)
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
