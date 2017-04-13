//
//  SZYCalendarMonth.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "SZYCalendarMonth.h"

@implementation SZYCalendarMonth
- (NSMutableArray *)calendarDays{
    if (_calendarDays==nil) {
        _calendarDays = [[NSMutableArray alloc]init];
    }
    return _calendarDays;
}
@end
