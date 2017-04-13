//
//  SZYCalendar.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "SZYCalendarManager.h"

@interface SZYCalendarManager()
@property (nonatomic,strong) NSArray *monthEnglishTexts;
@property (nonatomic,strong) NSArray *monthChineseTexts;
@end

@implementation SZYCalendarManager

+ (instancetype)sharedInstance{
    static SZYCalendarManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SZYCalendarManager new];
    });
    return instance;
}

- (NSArray *)monthEnglishTexts{
    if (_monthEnglishTexts==nil) {
        _monthEnglishTexts = @[@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",
                               @"Sep",@"Oct",@"Nov",@"Dec"];
    }
    return _monthEnglishTexts;
}
- (NSArray *)monthChineseTexts{
    if (_monthChineseTexts==nil) {
        _monthChineseTexts = @[@"一",@"二",@"三",@"四",@"五",@"六",
                               @"七",@"八",@"九",@"十",@"十一",@"十二"];
    }
    return _monthChineseTexts;
}


// 获取当前日期
- (NSDateComponents *)getCurrentComponents{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate *dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    return comp;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
//        NSDateComponents *fromComp = [self getComponentsWithYear:2017 month:1 day:10];
//        NSDateComponents *toComp = [self getComponentsWithYear:2017 month:2 day:5];
//        NSArray *arr = [self getMonthsForm:fromComp to:toComp isMonths:NO];
//        
//        NSLog(@"%@",arr);
    }
    return self;
}




// 通过年、月 获取这个月有多少天
- (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    BOOL isLeapYear = (year%4==0&&year%100!=0)||(year%100==0&&year%400==0);
    switch (month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
            return 31;
        case 4:case 6:case 9:case 11:
            return 30;
        case 2:{
            if (isLeapYear) {
                return 29;
            }else{
                return 28;
            }
        }
        default:break;
    }
    return 0;
}

// 传入一个日期 到另一个日期 获取  是否返回所有月份  否则返回所有天数
- (NSArray *)getMonthsForm:(NSDateComponents *)fromComp
                        to:(NSDateComponents *)toComp
                  isMonths:(BOOL)isMonth
{
    if (fromComp.year>toComp.year) {
        return nil;
    }
    if (fromComp.year == toComp.year &&
        fromComp.month > toComp.month) {
        return nil;
    }
    if (fromComp.year == toComp.year &&
        fromComp.month == toComp.month &&
        fromComp.day > toComp.day) {
        return nil;
    }
    // 总年数
    NSInteger yearCount = toComp.year - fromComp.year + 1;
    // 当前
    NSInteger currentYear = fromComp.year;
    NSInteger currentMonth = fromComp.month;
    
    NSMutableArray *allMonth = [NSMutableArray new];
    NSMutableArray *allDays = [NSMutableArray new];
    for (int i = 0; i < yearCount; i++) {// 年
        NSInteger monthCount;
        // 同一年
        if (yearCount==1) {
            monthCount = toComp.month - fromComp.month + 1;
            currentMonth = fromComp.month;
        }else{
            if (currentYear == toComp.year) {//最后一年
                monthCount = toComp.month;
                currentMonth = 1;
            }else if(currentYear == fromComp.year){//第一年
                monthCount = 12 - fromComp.month + 1;
                currentMonth = fromComp.month;
            }else{//中间年
                monthCount = 12;
                currentMonth = 1;
            }
        }
        
        for (int i = 0; i < monthCount; i++) {//月
            // 计算一个月
            SZYCalendarMonth *tempMonth = [SZYCalendarMonth new];
            tempMonth.year = currentYear;
            tempMonth.month = currentMonth;
            tempMonth.chMonthText = [NSString stringWithFormat:@"%@月",self.monthChineseTexts[currentMonth-1]];
            tempMonth.enMonthText = self.monthEnglishTexts[currentMonth-1];
            
            // 获取这个月多少天
            NSInteger days = [self getDaysWithYear:currentYear month:currentMonth];
            
            for (int i = 1; i <= days; i++) {
                NSInteger weekday = [self getComponentsWithYear:currentYear month:currentMonth day:i].weekday;
                SZYCalendarDay *tempDay = [SZYCalendarDay new];
                tempDay.day = i;
                tempDay.weekday = weekday;
                tempDay.year = currentYear;
                tempDay.month = currentMonth;
                
                tempDay.enMonthText = tempMonth.enMonthText;
                tempDay.chMonthText = tempMonth.chMonthText;
                tempDay.dayFormatText = [NSString stringWithFormat:@"%02d",i];
                [tempMonth.calendarDays addObject:tempDay];
                
                if (!isMonth) {
                    if (currentYear==fromComp.year &&
                        currentMonth == fromComp.month &&
                        i < fromComp.day) {//起始日
                        continue;
                    }
                    if (currentYear==toComp.year &&
                        currentMonth == toComp.month &&
                        i > toComp.day) {//结束日
                        break;
                    }
                    [allDays addObject:tempDay];
                }
            }
            currentMonth ++;
            [allMonth addObject:tempMonth];
        }
        currentYear ++;
    }
    if (isMonth) {//返回所有月
        return allMonth;
    }else{//返回所有天
        return allDays;
    }
}

// 根据年月日 获取日期组件
- (NSDateComponents *)getComponentsWithYear:(NSInteger)year
                                      month:(NSInteger)month
                                        day:(NSInteger)day
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 再次创建一个NSDateComponents对象
    NSDateComponents* comp2 = [[NSDateComponents alloc] init];
    // 设置各时间字段的数值
    comp2.year = year;
    comp2.month = month;
    comp2.day = day;
    // 通过NSDateComponents所包含的时间字段的数值来恢复NSDate对象
    NSDate *date = [gregorian dateFromComponents:comp2];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:date];
    return comp;
}

@end
