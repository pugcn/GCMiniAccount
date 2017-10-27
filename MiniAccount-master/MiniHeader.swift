//
//  MiniHeader.swift
//  MiniAccount-master
//
//  Created by puguichuan on 2017/10/10.
//  Copyright © 2017年 Pugc. All rights reserved.
//

import UIKit
import Foundation

let KWidth  = UIScreen.main.bounds.size.width
let KHeight  = UIScreen.main.bounds.size.height
let bgColor = UIColor.init(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
let bgBlackColor = UIColor.init(red: 43.0/255.0, green: 43.0/255.0, blue: 43.0/255.0, alpha: 1.0)
let btnColor = UIColor.init(red: 0.0/255.0, green: 167.0/255.0, blue: 175.0/255.0, alpha: 1.0)
let bgGrayColor = UIColor.init(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
let bgDateColor = UIColor.init(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
let bgDarkColor = UIColor.init(red: 69.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1.0)
let homeImgDict:Dictionary<String,String> = ["购物消费":"classify_icon_shop2x","餐饮":"classify_icon_diet2x","交通费":"classify_icon_transportation2x","休闲娱乐":"classify_icon_recreation2x","居家生活":"classify_icon_household2x","健康医疗":"classify_icon_medical2x","文化教育":"classify_icon_education2x","投资理财":"classify_icon_investment2x","其他支出":"classify_icon_other2x","收入":"classify_icon_income2x"]

struct HistoryHeader {
    var mounth : String?
    var year : String?
    var icoume : Double?
    var pay : Double?
}

struct DetailType {
    var detailName : String?
    var isSelected : Bool?
}
