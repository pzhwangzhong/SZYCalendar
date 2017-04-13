//
//  SZYCalendarView.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZYCalendarManager.h"

@class SZYCalendarView;
@protocol SZYCalendarViewDelegate <NSObject>
- (void)calendarView:(SZYCalendarView *)calendar selectCalendarDay:(SZYCalendarDay *)calendarDay;
@end
@interface SZYCalendarView : UIView
@property (nonatomic,weak) id<SZYCalendarViewDelegate> delegate;
@property (nonatomic,strong) SZYCalendarDay *selectDay;//当前选择的日期

/**
 * @params fromDate toDate 起止日期 
 * 可通过SZYCalendarManager类的以下方法获取 -[SZYCalendarManager getComponentsWithYear: month: day:]
 */
+ (instancetype)calenderViewWithFrame:(CGRect)frame
                             fromDate:(NSDateComponents *)fromDate
                               toDate:(NSDateComponents *)toDate;
@end
