//
//  BaseModel.swift
//  Cool
//
//  Created by ouyang on 2022/10/21.
//

import UIKit
import HandyJSON

class BaseModel: NSObject,HandyJSON {
    var code:Int = 0
    var data: AnyObject?
    var msg: String?
    required override init() {
    }
}

