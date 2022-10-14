//
//  HttpManager.m
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//  网络请求管理类

#import "HttpManager.h"
#import "BaseModel.h"
#import "RSA.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const PSW_AES_KEY = @"abcdefghijklmnop";
static NSString *const AES_IV_PARAMETER = @"1234567890123456";

static NSString *const DE_VICE = @"DEVICE";
static NSString *const DE_VICEID = @"DEVICEID";
static NSString *const VER_SION = @"VERSION";
static NSString *const TO_KEN = @"TOKEN";
static NSString *const EN_CRYPTKEY = @"ENCRYPTKEY";

//RSA公钥
static NSString *const PUBLIC_KEY = @"-----BEGIN PUBLIC KEY----- MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCq0WCtDHIAuufPOw49YU1P8NkP N30m+/NMZV+j0WA/lerRPtvpjLr0KHe03NaYowhWlG3R0SRswiivY7QPXTpmhiWk EN2Skxc7v11y86AtvNuCzGjQ0xkDDmw7V2gmkcMLowhGahVsIBX2C9P4YLqe+RYu rJItzAgBfTCfGVG+nwIDAQAB -----END PUBLIC KEY-----";


static HttpManager *_manager = nil;
static const int kRequestTimeoutInterval = 60;

@interface HttpManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) AFHTTPRequestSerializer *requestSerializer;
@property (nonatomic, strong) AFHTTPResponseSerializer *responseSerializer;
@property (nonatomic, copy) NSString *arckey;//随机字符串
@property (nonatomic, copy) NSString *encryptvalue;//随机字符串rsa加密后的值

@end

@implementation HttpManager

+ (HttpManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = self.requestSerializer;
        _sessionManager.responseSerializer = self.responseSerializer;
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;// 是不是使用证书验证
        _sessionManager.requestSerializer.HTTPShouldHandleCookies = YES;//保存cookie
        _sessionManager.securityPolicy.validatesDomainName = NO; //验证域名时，添加一个域名验证策略
    }
    return _sessionManager;
}

// 构造Params请求头
- (AFHTTPRequestSerializer *)requestSerializer {
        _requestSerializer= [AFHTTPRequestSerializer serializer];
     // 设置通用请求头字段
        [_requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        Logger(@"用户的的token:%@",[UtilManager getUserDefaultsforkey:kToken]);
//     if ([UtilManager getUserDefaultsforkey:kToken]) {
//           [_requestSerializer setValue:[UtilManager getUserDefaultsforkey:kToken] forHTTPHeaderField:@"access_token"];
//         }
    // 设置超时时间
        [_requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _requestSerializer.timeoutInterval = kRequestTimeoutInterval;
        [_requestSerializer didChangeValueForKey:@"timeoutInterval"];
       return _requestSerializer;
}

// 构造返回向应头
- (AFHTTPResponseSerializer *)responseSerializer {
    if (!_responseSerializer) {
        _responseSerializer = [AFHTTPResponseSerializer serializer];
        _responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/jpeg", @"application/x-www-form-urlencoded", @"multipart/form-data", @"application/octet-stream",@"text/plain; charset=utf-8", nil];
    }
    return _responseSerializer;
}

#pragma mark - HTTP请求方法

/** GET请求 */
- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    [self requestWithUrl:url method:RequestMethodGet params:params mapper:mapper showHUD:showHUD success:success failure:failure];
}

/** POST请求 */
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    [self requestWithUrl:url method:RequestMethodPost params:params mapper:mapper showHUD:showHUD success:success failure:failure];
}

/** PUT请求 */
- (void)putWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    [self requestWithUrl:url method:RequestMethodPut params:params mapper:mapper showHUD:showHUD success:success failure:failure];
}

/** DELETE请求 */
- (void)deleteWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
    [self requestWithUrl:url method:RequestMethodDelete params:params mapper:mapper showHUD:showHUD success:success failure:failure];
}

/* 接受params */
- (void)requestWithUrl:(NSString *)url method:(RequestMethod)method params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseModel *responseModel))success failure:(void (^)(NSError *error))failure {
    [self showHUD:showHUD];
    NSString *requestMethod = [self stringRequestMethod:method];
    NSError *serializationError = nil;
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", SERVER_URL, [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:requestMethod URLString:[[NSURL URLWithString:requestUrl relativeToURL:nil] absoluteString] parameters:params error:&serializationError];
    
    if (serializationError && failure) {
        dispatch_async([self sessionManager].completionQueue ?: dispatch_get_main_queue(), ^{
            failure(serializationError);
        });
    }
    
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *__unused response, id responseObject, NSError *error) {
        Logger(@"\n[** %@请求 **] \nREQUEST URL: %@ \nREQUEST PARAMS: %@ \nRESPONSE: %@ \n\n", requestMethod, requestUrl, [params mj_JSONString], [self responseToString:responseObject]);
        if (error) {
            if (failure) {
                failure(error);
                [self dismissHUD:showHUD];
                [self processError:error];
            }
            
        } else {
            if (success) {
                [self dismissHUD:showHUD];
                Logger(@"\n[** %@请求 **] \nREQUEST URL: %@ \nREQUEST PARAMS: %@ \nRESPONSE: %@ \n\n", requestMethod, url, [params mj_JSONString], [self responseToString:responseObject]);
                BaseModel *responseModel = [self processResponse:responseObject mapper:mapper];
                if (responseModel) {
                    success(responseModel);
                }
            }
        }
    }];
    [dataTask resume];
}

/* 接受body */
- (void)requestWithUrl:(NSString *)url method:(RequestMethod)method bodyParams:(NSDictionary *)bodyParams mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseModel *response))success failure:(void (^)(NSError *error))failure {
    [self showHUD:showHUD];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", SERVER_URL, [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet   characterSetWithCharactersInString:@"!$&'()*+-./:;=?@_~%#[]"]]];
    NSString *requestMethod = [self stringRequestMethod:method];
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:requestMethod URLString:[[NSURL URLWithString:requestUrl relativeToURL:nil] absoluteString] parameters:nil error:&serializationError];
    if (bodyParams) {
        [request setHTTPBody: [[bodyParams mj_JSONString]  dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (serializationError && failure) {
        dispatch_async([self sessionManager].completionQueue ?: dispatch_get_main_queue(), ^{
            failure(serializationError);
        });
    }
    Logger(@"\n[** %@请求 **] \nREQUEST URL: %@ \nREQUEST PARAMS: %@", requestMethod, requestUrl, [bodyParams mj_JSONString]);
    NSURLSessionDataTask *dataTask = [[self sessionManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *__unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(error);
                [self dismissHUD:showHUD];
                [self processError:error];
            }
            
        } else {
            if (success) {
                [self dismissHUD:showHUD];
                Logger(@"\n[** %@请求 **] \nREQUEST URL: %@ \nREQUEST PARAMS: %@ \nRESPONSE: %@ \n\n", requestMethod, requestUrl, [bodyParams mj_JSONString], [self responseToString:responseObject]);
                
                BaseModel *responseModel = [self processResponse:responseObject mapper:mapper];
                if (responseModel) {
                    success(responseModel);
                }
            }
        }
    }];
    [dataTask resume];
}

#pragma mark - Private Method
/* 处理HTTP RESPONSE */
- (BaseModel *)processResponse:(id)response mapper:(id)mapper {
    if (!response) {
        Logger(@"服务器返回为空: %@", response);
        return nil;
    }
    NSDictionary *responseDict = nil;
    NSMutableString *responsestr = nil;
    if ([response isKindOfClass:[NSDictionary class]]) {
        responseDict = response;

    }
    else if ([response isKindOfClass:[NSMutableString class]] ||[response isKindOfClass:[NSString class]] ){
        responsestr = response;
        NSData *jsonData = [responsestr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        responseDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    }
    else {
        responseDict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:(NSData *)response options:NSJSONReadingMutableContainers error:nil];
    }

    if (!responseDict) {
        Logger(@"服务器返回字典: %@", response);
        return nil;
    }

    BaseModel *responseModel = [BaseModel mj_objectWithKeyValues:response];
    if (responseModel.code == 200) {
        responseModel.data = [self mapperObjectWithResult:responseModel.data mapper:mapper];
        return responseModel;
    }else {
        NSString *message = responseModel.msg;
        if (![NSString isEmpty:message]) {
            [JYToastUtils showWithStatus:message];
        }
        return nil;
    }
}

/* 映射对象 */
- (id)mapperObjectWithResult:(id)resultDict mapper:(id)mapper {

    id mapperObject = nil;
    if (!mapper || mapper == [NSDictionary class] || mapper == [NSArray class]) {
        return resultDict;
    }

    if ([resultDict isKindOfClass:[NSDictionary class]]) {
        id model = [[mapper alloc] init];
        [model mj_setKeyValues:resultDict];
        mapperObject = model;

    } else if ([resultDict isKindOfClass:[NSArray class]]) {
        NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:[resultDict count]];
        for (id objDict in resultDict) {
            if ([objDict isKindOfClass:[NSString class]] || [objDict isKindOfClass:[NSValue class]]) {
                [modelArray addObject:objDict];

            } else {
                id model = [[mapper alloc] init];
                [model mj_setKeyValues:objDict];
                [modelArray addObject:model];
            }
        }
        mapperObject = modelArray;

    } else if (mapper == [NSString class]) {
        mapperObject = [NSString stringWithFormat:@"%@", resultDict];
        
    } else {
        mapperObject = resultDict;
    }
    return mapperObject;
}

// 转换成字符串信息
- (NSString *)responseToString:(id)response {
    NSData *data = (NSData *)response;
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        data = [NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (!responseStr) {
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        responseStr = [[NSString alloc] initWithData:data encoding:encoding];
    }
    return responseStr;
}

- (NSString *)stringRequestMethod:(RequestMethod)method {
    if (method == RequestMethodGet) {
        return @"GET";

    } else if (method == RequestMethodPost) {
        return @"POST";

    } else if (method == RequestMethodPut) {
        return @"PUT";

    } else if (method == RequestMethodDelete) {
        return @"DELETE";
    }

    return @"WARNING:请设置正确的HTTP请求方法";
}

// 处理错误信息
- (void)processError:(NSError *)error {
    Logger(@"REQUEST ERROR = %@\n", error);
    [JYToastUtils dismiss];
    NSInteger errorCode = error.code;
    NSString *errorMessage = error.localizedDescription;
    if (errorCode == -1001) {
        if ([errorMessage containsString:NSLocalizedString(@"请求超时", nil)] ||
            [errorMessage containsString:NSLocalizedString(@"The request timed out", nil)]) {
            [JYToastUtils showWithStatus:NSLocalizedString(@"请求超时", nil)];
            return;
        }

    } else if (errorCode == -1004) {
        if ([errorMessage containsString:NSLocalizedString(@"未能连接到服务器", nil)] ||
            [errorMessage containsString:@"Could not connect to the server"]) {
            [JYToastUtils showWithStatus:NSLocalizedString(@"未能连接到服务器", nil)];
            return;
        }

    } else if (errorCode == -1005) {
        if ([errorMessage containsString:NSLocalizedString(@"网络连接已中断", nil)] ||
            [errorMessage containsString:NSLocalizedString(@"The network connection was lost", nil)]) {
            [JYToastUtils showWithStatus:NSLocalizedString(@"网络连接已中断", nil)];
            return;
        }

    } else if (errorCode == -1009) {
        if ([errorMessage containsString:NSLocalizedString(@"似乎已断开与互联网的连接", nil)] ||
            [errorMessage containsString:NSLocalizedString(@"The Internet connection appears to be offline", nil)]) {
            Logger(@"***** 无网络连接: -1009 ***** ");
            return;
        }
    }
}

#pragma mark - JYToastUtils
- (void)showHUD:(BOOL)showHUD {
    if (showHUD) {
        [JYToastUtils dismiss];
        [JYToastUtils showLoading];
    }
}

- (void)dismissHUD:(BOOL)showHUD {
    if (showHUD) {
        [JYToastUtils dismiss];
    }
}

@end
