//
//  ViewController.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "ViewController.h"
#import "SZYCalendarView.h"
@interface ViewController ()<SZYCalendarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 开始日期
    NSDateComponents *fromComp = [[SZYCalendarManager sharedInstance] getComponentsWithYear:2015 month:1 day:1];
    // 结束日期
    NSDateComponents *toComp = [[SZYCalendarManager sharedInstance] getComponentsWithYear:2018 month:1 day:1];
    SZYCalendarView *calendarView = [SZYCalendarView calenderViewWithFrame:CGRectMake(0,50 , self.view.frame.size.width, 400) fromDate:fromComp toDate:toComp];
    calendarView.delegate = self;
    [self.view addSubview:calendarView];
    
    SZYCalendarDay * calendarDay = calendarView.selectDay;
    NSLog(@"%ld年 %ld月 %ld日  星期%ld",calendarDay.year,calendarDay.month,calendarDay.day,calendarDay.weekday);
}

#pragma mark - SZYCalendarViewDelegate
- (void)calendarView:(SZYCalendarView *)calendar selectCalendarDay:(SZYCalendarDay *)calendarDay{
    NSLog(@"%ld年 %ld月 %ld日  星期%ld",calendarDay.year,calendarDay.month,calendarDay.day,calendarDay.weekday);
}

@end
