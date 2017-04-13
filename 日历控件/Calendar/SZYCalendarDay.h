//
//  SZYCalendarItem.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SZYCalendarMonth;

@interface SZYCalendarDay : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger weekday;

@property (nonatomic,copy) NSString *dayFormatText;//日期格式化文本
@property (nonatomic,copy) NSString *chMonthText;//月份中文文本
@property (nonatomic,copy) NSString *enMonthText;//月份英文文本
@end
