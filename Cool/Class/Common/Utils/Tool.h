//
//  Tool.h
//  Cool
//
//  Created by ouyang on 2022/10/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tool : NSObject

@property (nonatomic, assign) BOOL firstStartApplication;

+ (instancetype)shareManager;

/**获取状态栏高度*/
+ (CGFloat)getStatusBarHeight;

/**获取缓存地址*/
+ (NSString *)getCachesPath;

/** base64*/
+ (NSString *)base64StringWithString:(NSString *)string;

+ (NSString *)stringWithBase64String:(NSString *)bs4String;

/**
格式化小数点后面的0
 */
+ (NSString *)formatZero:(NSString *)string;

/**
  根据文字大小获取文字宽度
*/
+ (CGFloat)getWidth:(NSString *)str labelFont:(UIFont *)font Height:(float)height;

+ (CGFloat)getWidth:(NSString *)str labelFont:(UIFont *)font Height:(float)height maxWidth:(CGFloat)maxWidth;

+ (CGFloat)getHeight:(NSString *)str labelFont:(UIFont *)font Width:(float)width;

+ (CGFloat)getHeight:(NSString *)str labelFont:(UIFont *)font Width:(float)width maxHeight:(CGFloat)maxHeight;


/**时间戳转换为制定格式的日期 默认：YYYY-MM-dd HH:mm*/
+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp dateFormate:(NSString *)dateFormate;

/**date转换为制定格式的日期*/
+ (NSString *)dateStrWithDate:(NSDate *)date dateFormate:(NSString *)dateFormate;

+ (NSDate *)dateWithDateString:(NSString *)dateStr dateFormate:(NSString *)dateFormate;

/**获取时间是今天还是昨天还 当前年份的某个日期*/
+ (NSString *)timeStringShowTodayWithDateString:(NSString *)dateStr;
/**获取时间戳是今天还是昨天还 当前年份的某个日期*/
+ (NSString *)dateStringShowTodayWithTimestamp:(long long )timestamp;

/** 日期转时间时间戳*/
+ (NSInteger)timeStringWithTimeInterval:(NSDate*)date withdateFormate:(NSString *)dateFormate;

//比较2个date日期的大小 a>b = -1;a=b = 0; a
+ (NSInteger )compareDate:(NSDate* )aDate withDate:(NSDate* )bDate;

/* 获取多少天后的日期 */
+ (NSDate*)getafterdataBy:(NSInteger)deadline;

/**
 *富文本设置两部分不同的颜色和字体大小
 * str:总的格式化字符串
 * oneStr:第一部分式化字符串
 * colorOne:第一部分要格式化的字符串颜色
 * onefont:第一部分要格式化的字符字体大小
 * str:总的格式化字符串
 */
+ (NSAttributedString *)setupAttributeString:(NSString *)str withColorOneStr:(NSString *)oneStr andColorOne:(UIColor *)colorOne  andoneFont:(UIFont*)onefont  andColorTwoStr:(NSString *)twoStr  andtwoFont:(UIFont*)twofont andColorTwo:(UIColor *)colorTwo;

/**
 * 富文本设置一部分部分不同的颜色和字体大小
 * str:总的格式化字符串
 * rangeText:第一部分式化字符串
 * textColor:第一部分要格式化的字符串颜色
 * Font:第一部分要格式化的字符字体大小
 */
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)str rangeText:(NSString *)rangeText textColor:(UIColor *)color  Font:(UIFont*)font;
/**上下换行文字的富文本设置*/
+ (NSMutableAttributedString*)setupAttributedString:(NSString*)alltext withsubtext:(NSString*)subtext withsubfont:(UIFont*)subfount withlinespace:(CGFloat)linspace  withsubcolor:(UIColor*)subcolor;

 /* 获取当前日期 */
+ (NSString *)getCurrentDate;

/* 获取当前时间戳 */
+ (long)getCurrentInterval;

/* json字符串转字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/* 字典转json字符串*/
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

/**保存/获取整形数据值*/
+ (void)setIntgerValue:(NSInteger)value  forkey:(NSString*)key;
+ (double)getIntgerValue:(NSString*)key;

/** 得到星座的算法 */
+ (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d;

/** 判断输入的是否为数字和字母  */
+ (BOOL)deptinputstring:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
