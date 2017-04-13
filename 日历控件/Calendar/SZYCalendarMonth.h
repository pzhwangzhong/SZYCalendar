//
//  SZYCalendarMonth.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZYCalendarDay.h"
@interface SZYCalendarMonth : NSObject
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,strong) NSMutableArray<SZYCalendarDay *> *calendarDays;

@property (nonatomic,copy) NSString *chMonthText;//月份中文文本
@property (nonatomic,copy) NSString *enMonthText;//月份英文文本
@end
