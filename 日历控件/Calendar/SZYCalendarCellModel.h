//
//  SZYCalendarCellVModel.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZYCalendarDay.h"
@interface SZYCalendarCellModel : NSObject
@property (nonatomic,strong) SZYCalendarDay *calendarDay;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL select;
@end
