//
//  HttpManager.h
//
//  Created by JY on 2018/6/7.
//  Copyright © 2018年 蓝海科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestMethod) {
    RequestMethodGet,
    RequestMethodPost,
    RequestMethodPut,
    RequestMethodDelete
};

@class BaseModel;

@interface HttpManager : NSObject

+ (HttpManager *)sharedManager;

/** GET请求 */
- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseResponseModel *response))success failure:(void (^)(NSError *error))failure;

/** POST请求 */  
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseResponseModel *response))success failure:(void (^)(NSError *error))failure;

/** PUT请求 */
- (void)putWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseResponseModel *response))success failure:(void (^)(NSError *error))failure;

/** DELETE请求 */
- (void)deleteWithUrl:(NSString *)url params:(NSDictionary *)params mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseResponseModel *response))success failure:(void (^)(NSError *error))failure;

/* 接受body */
- (void)requestWithUrl:(NSString *)url method:(RequestMethod)method bodyParams:(NSDictionary *)bodyParams mapper:(id)mapper showHUD:(BOOL)showHUD success:(void (^)(BaseResponseModel *response))success failure:(void (^)(NSError *error))failure;


@end
