//
//  SZYCalendarTitle.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SZYCalendarClickTypeUpYear,
    SZYCalendarClickTypeNextYear,
    SZYCalendarClickTypeUpMonth,
    SZYCalendarClickTypeNextMonth,
} SZYCalendarClickType;
@class SZYCalendarTitle;
@protocol SZYCalendarTitleDelegate <NSObject>
- (void)calendarTitle:(SZYCalendarTitle *)view clickType:(SZYCalendarClickType)clickType;
@end

@interface SZYCalendarTitle : UIView
@property (nonatomic,weak) id<SZYCalendarTitleDelegate> delegate;
@property (nonatomic,strong) UILabel *titleLabel;
@end
