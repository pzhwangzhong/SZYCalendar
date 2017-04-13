//
//  SZYCalendarVModel.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SZYCalendarCellModel.h"
@interface SZYCalendarModel : NSObject
@property (nonatomic,strong) NSMutableArray *allModels;
@property (nonatomic,strong) NSArray *allMonths;


- (void)setDateWithFromDate:(NSDateComponents *)fromDate toDate:(NSDateComponents *)toDate;
@end
