//
//  SZYCalendarVModel.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "SZYCalendarModel.h"
#import "SZYCalendarManager.h"

@interface SZYCalendarModel()
@property (nonatomic,strong) SZYCalendarManager *calenderManager;
@property (nonatomic,strong) NSDateComponents *currentComp;
@end
@implementation SZYCalendarModel

- (NSDateComponents *)currentComp{
    if (_currentComp==nil) {
        _currentComp = [self.calenderManager getCurrentComponents];
    }
    return _currentComp;
}


- (void)setDateWithFromDate:(NSDateComponents *)fromDate toDate:(NSDateComponents *)toDate{
    _allMonths = [[SZYCalendarManager sharedInstance] getMonthsForm:fromDate to:toDate isMonths:YES];
}

- (SZYCalendarManager *)calenderManager{
    if (_calenderManager==nil) {
        _calenderManager = [[SZYCalendarManager alloc]init];
    }
    return _calenderManager;
}
- (NSMutableArray *)allModels{
    if (_allModels==nil) {
        _allModels = [[NSMutableArray alloc]init];
        for (SZYCalendarMonth *monthModel in self.allMonths) {
            NSMutableArray *tempArr = [NSMutableArray new];
            // 添加cell模型
            //第一行需要添加的空白cell
            SZYCalendarDay *firstDay = monthModel.calendarDays.firstObject;
            NSInteger startIndex = firstDay.weekday - 1;//从第几个下标开始添加
            NSInteger endIndex = startIndex + monthModel.calendarDays.count - 1;//到第几个下标结束
            for (int i = 0; i < 42; i++) {
                SZYCalendarCellModel *cellModel = [SZYCalendarCellModel new];
                if (i<startIndex||i>endIndex) {
                    cellModel.title = nil;
                    cellModel.select = NO;
                }else{
                    SZYCalendarDay *dayModel = monthModel.calendarDays[i-startIndex];
                    cellModel.calendarDay = dayModel;
                    cellModel.title = [@(dayModel.day) stringValue];
                    
                    // 是否选中
                    if (self.currentComp.year == cellModel.calendarDay.year &&
                        self.currentComp.month == cellModel.calendarDay.month &&
                        self.currentComp.day == cellModel.calendarDay.day ) {
                        cellModel.select = YES;
                    }else{
                        cellModel.select = NO;
                    }
                }
                
                [tempArr addObject:cellModel];
            }
            
            [_allModels addObject:tempArr];
        }
    }
    return _allModels;
}
@end
