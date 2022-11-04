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
    case uploadHeadImage(parameters: [String:Any], imageDate:Data)
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
        case .uploadHeadImage(parameters: _, imageDate: _):
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
            
        case .uploadHeadImage(parameters: let parameters, imageDate: let imgDate):
            let formData = MultipartFormData(provider: .data(imgDate), name: "file",
                                             fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)

        }
    }
    
    public var headers: [String : String]? {
        
         return ["Content-Type":"application/json"]
  }
 
}
