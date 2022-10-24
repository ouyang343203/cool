//
//  loginModel.swift
//  Cool
//
//  Created by ouyang on 2022/10/21.
//

import UIKit
import HandyJSON

// 轮播图数据 model
//struct LoginModel: HandyJSON {
//    var urlType:Int = 0
//    var goodsId: String?
//    var image: String?
//    var useronfo: UserInfoModel?
//}

struct UserInfoModel: HandyJSON {
    var image: String?
    var mallCategoryName: String?
    var mallCategoryId: String? // 传值
    var bxMallSubDto: [CategorySmallModel]?
}

struct CategorySmallModel: HandyJSON{
    var TO_PLACE: String?
    var PICTURE_ADDRESS: String?
    var urlType: Int = 0
}

//class CategorySmallModel: HandyJSON {
//    var mallSubName: String?
//    var mallSubId: String?  // CategorySubId
//    var mallCategoryId: String?
//    var comments: String?
//    var isSelect: Bool?
//    required init() {
//    }
//}
