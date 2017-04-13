//
//  SZYCalendar.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZYCalendarMonth.h"
@interface SZYCalendarManager : NSObject

+ (instancetype)sharedInstance;

/**
 * 获取当前日期
 */
- (NSDateComponents *)getCurrentComponents;

/**
 * 根据年月日 获取日期
 */
- (NSDateComponents *)getComponentsWithYear:(NSInteger)year
                                      month:(NSInteger)month
                                        day:(NSInteger)day;

/**
 * @pramas fromComp 开始日期
 * @pramas toComp 结束日期
 * @pramas isMonth YES 返回所有月份 NO 返回所有天
 * @return NSArray 数组
 */
- (NSArray *)getMonthsForm:(NSDateComponents *)fromComp
                        to:(NSDateComponents *)toComp
                  isMonths:(BOOL)isMonth;
@end
