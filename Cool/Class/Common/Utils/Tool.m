//
//  Tool.m
//  Cool
//
//  Created by ouyang on 2022/10/17.
//

#import "Tool.h"

@implementation Tool

+ (instancetype)shareManager {
    
    static Tool *toolManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolManager = [[Tool alloc] init];
    });
    return toolManager;
}

/**第一次进入app*/
-(void)setFirstStartApplication:(BOOL)firstStartApplication {
    
    [kUserDefaults setBool:firstStartApplication forKey:@"firstStartApplication"];
    [kUserDefaults synchronize];
}

- (BOOL)firstStartApplication {
    return [kUserDefaults boolForKey:@"firstStartApplication"];
}

/**获取状态栏高度*/
+ (CGFloat)getStatusBarHeight {
    
    CGFloat statusBarHeight = 0.0f;
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    }else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

/**获取缓存地址*/
+ (NSString *)getCachesPath {
    
    NSArray * cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * cachesDirectory = [cachesPaths objectAtIndex:0];
    return cachesDirectory;
}

/** base64*/
+ (NSString *)base64StringWithString:(NSString *)string {
    
    NSData *plainData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}

+ (NSString *)stringWithBase64String:(NSString *)bs4String {
    
    NSInteger dMod = bs4String.length % 4;
    NSString *base64Str = bs4String;
    if (dMod) {
        base64Str = [base64Str stringByAppendingString:[@"====" substringFromIndex:dMod]];
    }
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64Str options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

/**
格式化小数点后面的0
 */
+ (NSString *)formatZero:(NSString *)string {
    NSInteger offset = string.length - 1;
    while (offset) {
        NSString *temp = [string substringWithRange:NSMakeRange(offset, 1)];
        if ([temp isEqualToString:@"0"] || [temp isEqualToString:@"."]) {
            offset--;
            if ([temp isEqualToString:@"."]) {
                break;
            }
        } else {
            break;
        }
    }
    return [string substringToIndex:offset + 1];
}

/**
  根据文字大小获取文字宽度
*/
+ (CGFloat)getWidth:(NSString *)str labelFont:(UIFont *)font Height:(float)height{
    
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return actualSize.width;
}

+ (CGFloat)getWidth:(NSString *)str labelFont:(UIFont *)font Height:(float)height maxWidth:(CGFloat)maxWidth {
    
    CGSize size = CGSizeMake(maxWidth, height);
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    return actualSize.width;
}


+ (CGFloat)getHeight:(NSString *)str labelFont:(UIFont *)font Width:(float)width {
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return actualSize.height;
}

+ (CGFloat)getHeight:(NSString *)str labelFont:(UIFont *)font Width:(float)width maxHeight:(CGFloat)maxHeight {
    
    CGSize size = CGSizeMake(width, maxHeight);
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return actualSize.height;
}

/**时间戳转换为制定格式的日期 默认：YYYY-MM-dd HH:mm*/
+ (NSString *)timeStringWithTimestamp:(NSTimeInterval)timestamp dateFormate:(NSString *)dateFormate {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *ft = [[NSDateFormatter alloc] init];
    if(!dateFormate){
        ft.dateFormat = dateFormate;
    }
    ft.dateFormat = dateFormate ? dateFormate : @"YYYY-MM-dd HH:mm";
    NSString *timeStr = [ft stringFromDate:date];
    return timeStr;
}

/**date转换为制定格式的日期*/
+ (NSString *)dateStrWithDate:(NSDate *)date dateFormate:(NSString *)dateFormate {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式
    [dateFormatter setDateFormat:dateFormate]; // yyyy-MM-dd HH:mm:ss
    //用[NSDate date]获取当前时间并转字符串
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSDate *)dateWithDateString:(NSString *)dateStr dateFormate:(NSString *)dateFormate {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //拷贝时间格式，与字符串格式相同
    [dateFormatter setDateFormat:dateFormate];
    //把字符串theTime转为日期
    NSDate *theDate = [dateFormatter dateFromString:dateStr];
    return theDate;
}

+ (NSString *)timeStringShowTodayWithDateString:(NSString *)dateStr {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [format dateFromString:dateStr];
    
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    BOOL isYesterday = [[NSCalendar currentCalendar] isDateInYesterday:date];
    
    if(isToday) {
        [format setDateFormat:@"今天 HH:mm"];
    } else if (isYesterday) {
        [format setDateFormat:@"昨天 HH:mm"];
    } else {
        int unit = NSCalendarUnitYear;
        NSDateComponents *nowCmps =  [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
        NSDateComponents *dateCmps = [[NSCalendar currentCalendar] components:unit fromDate:date];
        if (nowCmps.year == dateCmps.year) { // 是否是今年
            [format setDateFormat:@"MM-dd HH:mm"];
        } else {
            [format setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    return [format stringFromDate:date];
}


+ (NSString *)dateStringShowTodayWithTimestamp:(long long )timestamp {
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    BOOL isYesterday = [[NSCalendar currentCalendar] isDateInYesterday:date];
    
    if(isToday) {
        return @"今天";
    } else if (isYesterday) {
        return @"昨天";
    } else {
        int unit = NSCalendarUnitYear;
        NSDateComponents *nowCmps =  [[NSCalendar currentCalendar] components:unit fromDate:[NSDate date]];
        NSDateComponents *dateCmps = [[NSCalendar currentCalendar] components:unit fromDate:date];
        if (nowCmps.year == dateCmps.year) { // 是否是今年
            [format setDateFormat:@"MM-dd"];
        } else {
            [format setDateFormat:@"yyyy-MM-dd"];
        }
    }
    return [format stringFromDate:date];
}

/** 日期转时间时间戳*/
+ (NSInteger)timeStringWithTimeInterval:(NSDate*)date withdateFormate:(NSString *)dateFormate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormate]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区选择北京时间
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
     
    NSString *dateStr = [formatter stringFromDate:date];
    NSDate* tempdate = [formatter dateFromString:dateStr]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[tempdate timeIntervalSince1970]] integerValue];
   return timeSp;
}

//比较2个date日期的大小 a>b = -1;a=b = 0; a
+ (NSInteger )compareDate:(NSDate* )aDate withDate:(NSDate* )bDate {

    NSInteger tag = 0;
    NSComparisonResult result = [aDate compare:bDate];
    if(result == NSOrderedAscending) { // aDate < bDate
       tag = -1;
    }
    else if (result == NSOrderedSame) { // aDate == bDate
       tag = 0;
    }
    else {// aDate > bDate
       tag = 1;
    }
    return tag;
}

/* 获取多少天后的日期 */
+ (NSDate*)getafterdataBy:(NSInteger)deadline {
    
    NSDate *date = [NSDate date];NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60*deadline sinceDate:date];
    
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];// you can use your format.
    NSString *timeStr = [dateFormat stringFromDate:nextDate];
    Logger(@"============%@",timeStr);
    return nextDate;
    
//    /*算到毫秒*/
//    NSTimeInterval tempMilli = (long long)deadline;
//    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
//    Logger(@"传入的时间戳=%f",seconds);
//    return [NSDate dateWithTimeIntervalSince1970:seconds];

}

/**
 * 富文本设置两部分不同的颜色和字体大小
 * str:总的格式化字符串
 * oneStr:第一部分式化字符串
 * colorOne:第一部分要格式化的字符串颜色
 * onefont:第一部分要格式化的字符字体大小
 * str:总的格式化字符串
 */
+ (NSAttributedString *)setupAttributeString:(NSString *)str withColorOneStr:(NSString *)oneStr andColorOne:(UIColor *)colorOne  andoneFont:(UIFont*)onefont  andColorTwoStr:(NSString *)twoStr  andtwoFont:(UIFont*)twofont andColorTwo:(UIColor *)colorTwo {
   
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:str];
    NSRange range1=[[hintString string]rangeOfString:oneStr];
    [hintString addAttribute:NSForegroundColorAttributeName value:colorOne range:range1];
    [hintString addAttribute:NSFontAttributeName value:onefont range:range1];
    
    NSRange range2=[[hintString string]rangeOfString:twoStr];
    [hintString addAttribute:NSForegroundColorAttributeName value:colorTwo range:range2];
    [hintString addAttribute:NSFontAttributeName value:twofont range:range2];
    
    return hintString;
}

/**
 * 富文本设置一部分部分不同的颜色和字体大小
 * str:总的格式化字符串
 * rangeText:第一部分式化字符串
 * textColor:第一部分要格式化的字符串颜色
 * Font:第一部分要格式化的字符字体大小
 */
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)str rangeText:(NSString *)rangeText textColor:(UIColor *)color  Font:(UIFont*)font{
    NSRange hightlightTextRange = [str rangeOfString:rangeText];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    if (hightlightTextRange.length > 0) {
        
        [attributeStr addAttribute:NSForegroundColorAttributeName
         
                             value:color
         
                             range:hightlightTextRange];
        
        [attributeStr addAttribute:NSFontAttributeName value:font range:hightlightTextRange];
        
        return attributeStr;
        
    }else {
        
        return [rangeText copy];
        
    }
}

/**上下换行文字的富文本设置*/
+ (NSMutableAttributedString*)setupAttributedString:(NSString*)alltext withsubtext:(NSString*)subtext withsubfont:(UIFont*)subfount withlinespace:(CGFloat)linspace  withsubcolor:(UIColor*)subcolor {
    NSRange hightlightTextRange = [alltext rangeOfString:subtext];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:alltext];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:subcolor
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:subfount range:hightlightTextRange];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        [paraStyle setLineSpacing:linspace];
        paraStyle.alignment = NSTextAlignmentCenter;
        [attributeStr addAttributes:@{NSParagraphStyleAttributeName:paraStyle} range:NSMakeRange(0, alltext.length)];
        return attributeStr;
        
    }else {
        return [alltext copy];
    }
}

 /* 获取当前日期 */
+ (NSString *)getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSDate *datenow = [NSDate date];
    NSString *currentdate = [formatter stringFromDate:datenow];  //----------将nsdate按formatter格式转成nsstring
    return currentdate;
}

/* 获取当前时间戳 */
+ (long)getCurrentInterval {
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    long timeInterval = (long) ([dat timeIntervalSince1970]);
    return timeInterval;
}

/* json字符串转字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        return nil;
    }
    return dic;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary) {
        return @"";
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}


/**
保存/获取整形数据值
*/
+ (void)setIntgerValue:(NSInteger)value  forkey:(NSString*)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:value forKey:key];
    [ud synchronize];
}

+ (double)getIntgerValue:(NSString*)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSInteger value = [ud doubleForKey:key];
    return value;
}

/** 得到星座的算法 */
+ (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d {
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (m<1||m>12||d<1||d>31){
        
        return @"错误日期格式!";
        
    }
    
    if(m==2 && d>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return [result stringByAppendingString:@"座"];
    
}

/** 判断输入的是否为数字和字母  */
+ (BOOL)deptinputstring:(NSString *)str {
     if (str.length == 0) {
         return NO;
     }
     NSString *regex = @"[a-zA-Z0-9]*";
     NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
     if ([pred evaluateWithObject:str]) {
         return YES;
     }
     return NO;
}

@end
