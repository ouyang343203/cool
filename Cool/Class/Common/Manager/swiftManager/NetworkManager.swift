//
//  NetworkManager.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 4/2/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import Foundation
import HandyJSON
import Moya
import Alamofire
import ObjectMapper
import SwiftyJSON

/// 超时时长
private var requestTimeOut:Double = 30
///成功数据的回调
typealias successCallback = ((BaseModel<Any>) -> (Void))
///失败的回调
typealias failedCallback = ((String) -> (Void))

// 成功回调
typealias RequestSuccessCallback = ((_ model: Any?) -> Void)
// 失败回调
typealias RequestFailureCallback = ((_ code: Int?, _ message: String?) -> Void)


///网络错误的回调
typealias errorCallback = (() -> (Void))


// MARK:  mark - 网络请求的基本设置,定义请求头相关信息
private let myEndpointClosure = { (target: API) -> Endpoint in
    ///这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    var task = target.task

    /* 如果需要在每个请求中都添加类似公共参数如：token参数的参数请取消注释下面代码 */
    var tokenParam = ["token":"","unique_id":""]
    let defaultEncoding = URLEncoding.default
     task = .requestParameters(parameters: tokenParam as [String : Any], encoding: defaultEncoding)
    
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30//每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    return endpoint
}

// MARK:  mark - 网络请求的设置用于定义当 Endpoint 有问题时，提前拦截请求
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("请求接口\(request.url!)"+"\n"+"请求方式\(request.httpMethod ?? "")"+"\n"+"请求参数\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/*   设置ssl
let policies: [String: ServerTrustPolicy] = [
    "example.com": .pinPublicKeys(
        publicKeys: ServerTrustPolicy.publicKeysInBundle(),
        validateCertificateChain: true,
        validateHost: true
    )
]
*/

private let RequestAlertPlugin = NetworkActivityPlugin.init { changeType, _ in
    print("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    switch changeType {
    case .began:
        print("开始请求网络")
        JYToastUtils.showLoading()
        
    case .ended:
        print("结束")
        JYToastUtils.dismiss()
    }
}

let networkPlugin = RequestAlertPlugin
// MARK:  mark - 网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
func NetworkRequest<T:Mappable>(target: API, modelType: T.Type, successCallback:RequestSuccessCallback?, failureCallback: RequestFailureCallback?){
    //先判断网络是否有链接 没有的话直接返回--代码略
    if !isNetworkConnect{
       JYToastUtils.showShort(withStatus: "网络链接失败")
        return
    }
    //这里显示loading图
    Provider.request(target) { (result) in
        //隐藏hud
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSON(data: response.data)
                print("返回数据:",jsonData)
                if jsonData["data"].dictionaryObject == nil, jsonData["data"].arrayObject == nil { // 返回字符串
                    JYToastUtils.showShort(withStatus: jsonData["data"].string)
                    return
                }
                
                if jsonData["data"].dictionaryObject != nil { // 字典转model
                    if let model = T(JSONString: jsonData["data"].rawString() ?? "") {
                        successCallback!(model)
                    }
                    else{
                        JYToastUtils.showShort(withStatus: "请求失败")
                    }
                }else if jsonData["data"].arrayObject != nil { // 数组转model
                    if let model = [T](JSONString: jsonData["data"].rawString() ?? "") {
                        successCallback?(model)
                    } else {
                        failureCallback?(jsonData["data"].intValue, "解析失败")
                    }
                }

            } catch {
                JYToastUtils.showShort(withStatus: "网络链接失败")
            }
        case .failure(_):
            JYToastUtils.showShort(withStatus: "请求失败")
            failureCallback?(nil, "网络连接失败")
        }
    }
}
/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
var isNetworkConnect: Bool {
    get{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true //无返回就默认网络已连接
    }
}
