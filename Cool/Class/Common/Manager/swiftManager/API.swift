//
//  API.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 3/30/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md

import Foundation
import Moya

enum API{
    case login(parameters:[String:Any])
    case register(parameters:[String:Any])
    case balencelist(parameters:[String:Any])
    case uploadHeadImage(parameters: [String:Any], imageData:Data)
    case uploadImage(parameters: [String:Any], dataAry:Data)
}

extension API: TargetType{
    
    public var baseURL: URL {

        switch self {
        default:
            return URL(string: Moya_baseURL)!
        }
      }
      
    public var path: String {
        
        switch self {
        case .login:
            return login_API
        case .register:
            return "/index.php?m=Api&c=User&a=user_cash_out"
        case .balencelist:
            return balence_API // 收益明细
        case .uploadHeadImage(parameters: _, imageData: _):
            return "/file/user/upload.jhtml"
        case .uploadImage(parameters: _, dataAry: _):
            return "/file/user/upload.jhtml"
      }
    }
    
    public var method: Moya.Method {
        var retMethod = Method.get
        switch self {
        case .login:
            retMethod = .post
            break
        case .register:
            retMethod = .post
            break
        default:
            retMethod = .post
        }
        return retMethod
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data{
        return "".data(using: .utf8)!
    }
    
    //请求的参数在这里处理
    public var task: Task{
        switch self {
        case let .login(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .register(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case let .balencelist(parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .uploadHeadImage(parameters: let parameters, imageData: let imgData):
            let formData = MultipartFormData(provider: .data(imgData), name: "file",
                                             fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
            
        case .uploadImage(parameters: let parameters, dataAry: let imgDatas):
            
            let formDataAry:NSMutableArray = NSMutableArray()
            for (index,image) in imgDatas.enumerated() {
                //图片转成Data
                let data:Data = (image as! UIImage).jpegData(compressionQuality: 0.9)!
               //根据当前时间设置图片上传时候的名字
                let date:Date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
                var dateStr:String = formatter.string(from: date as Date)
                //别忘记这里给名字加上图片的后缀哦
                dateStr = dateStr.appendingFormat("-%i.png", index)
               
                let formData = MultipartFormData(provider: .data(data), name: "file", fileName: dateStr, mimeType: "image/jpeg")
                formDataAry.add(formData)
           }
            return .uploadCompositeMultipart(formDataAry as! [MultipartFormData], urlParameters: parameters )
        }
    }
    
    public var headers: [String : String]? {
        
         return ["Content-Type":"application/json"]
  }
 
}
