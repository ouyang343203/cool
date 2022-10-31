//
//  BaseModel.swift
//  Cool
//
//  Created by ouyang on 2022/10/21.
//

import UIKit
import ObjectMapper
import HandyJSON

class BaseModel<T:Any>:HandyJSON,Mappable {
    required init?(map: ObjectMapper.Map) {
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
    }
    
    var data : T? // 主要数据
    var code:Int = 0
    var msg: String?
    required public init() {}
}

