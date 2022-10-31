//
//  BuranrModel.swift
//  ShopProject
//
//  Created by ouyang on 2022/10/26.
//  Copyright © 2022 mziyuting. All rights reserved.
//

import UIKit
import ObjectMapper
import HandyJSON

class BuranrModel: HandyJSON {
    var data: [GoodsModel]?
    required init() {
    }
}


// 商品信息
class GoodsModel: Mappable{
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        goodsId    <- map["goodsId"]
        image      <- map["image"]
        name       <- map["name"]
        price      <- map["price"]
        mallPrice  <- map["mallPrice"]
    }
    
    var goodsId: String?
    var image: String?
    var name: String?
    var price: Float?
    var mallPrice: Float?
    required init() {
    }
}


// 商品信息
struct shangpingModel: HandyJSON{
    var goodsId: String?
    var image: String?
    var name: String?
    var price: Float?
    var mallPrice: Float?
}
