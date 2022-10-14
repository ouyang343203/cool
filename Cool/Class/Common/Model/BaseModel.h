//
//  BaseModel.h
//  Cool
//
//  Created by ouyang on 2022/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *msg; // 请求返回信息处理

@end

NS_ASSUME_NONNULL_END
