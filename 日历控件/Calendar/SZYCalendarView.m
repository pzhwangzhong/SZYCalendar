//
//  SZYCalendarView.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "SZYCalendarView.h"
#import "SZYCalendarModel.h"
#import "SZYCalendarCell.h"
#import "SZYCalendarTitle.h"
#import "SZYCalendarManager.h"

@interface SZYCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource,SZYCalendarCellDelegate,SZYCalendarTitleDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) SZYCalendarModel *viewModel;
@property (nonatomic,strong) SZYCalendarTitle *calendarTitle;
@property (nonatomic,assign) NSInteger currentIndex;
@end


static NSString *const cellId = @"cellId";
@implementation SZYCalendarView


- (SZYCalendarModel *)viewModel{
    if (_viewModel==nil) {
        _viewModel = [[SZYCalendarModel alloc]init];
    }
    return _viewModel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

+ (instancetype)calenderViewWithFrame:(CGRect)frame
                             fromDate:(NSDateComponents *)fromDate
                               toDate:(NSDateComponents *)toDate
{
    SZYCalendarView *calenView = [[self alloc]initWithFrame:frame];
    [calenView.viewModel setDateWithFromDate:fromDate toDate:toDate];
    [calenView setup];
    return calenView;
}

// 初始化
- (void)setup{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width;
    CGFloat titleH = height * 0.2;
    CGFloat contentH = height - titleH;
    
    _calendarTitle = [[SZYCalendarTitle alloc]initWithFrame:CGRectMake(0, 0, width, titleH)];
    _calendarTitle.delegate = self;
    [self addSubview:_calendarTitle];
    _calendarTitle.backgroundColor = [UIColor redColor];
    
    // 布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;//列间距
    layout.minimumLineSpacing = 0;//行间距
    layout.itemSize = CGSizeMake(width, contentH);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, titleH, width, contentH ) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    //注册
    [_collectionView registerClass:[SZYCalendarCell class] forCellWithReuseIdentifier:cellId];
    self.backgroundColor = [UIColor whiteColor];
    
    
    // 设置当前月
    NSDateComponents *comp = [[SZYCalendarManager sharedInstance] getCurrentComponents];
    SZYCalendarMonth *currentMonth;
    SZYCalendarDay *currentDay;
    for (SZYCalendarMonth *month in self.viewModel.allMonths) {
        if (month.year == comp.year && month.month == comp.month) {
            currentMonth = month;
        }
        for (SZYCalendarDay *day in month.calendarDays) {
            if (day.year == comp.year && day.month == comp.month && day.day == comp.day) {
                currentDay = day;
            }
        }
        
    }
    if (currentMonth) {
        NSInteger index = [self.viewModel.allMonths indexOfObject:currentMonth];
        self.currentIndex = index;
        [self scrollToIndex:self.currentIndex];
    }else{
        currentMonth = self.viewModel.allMonths.firstObject;
        self.currentIndex = 0;
    }
    self.selectDay = currentDay;
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.allModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SZYCalendarCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.cellModels = self.viewModel.allModels[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = self.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / width;
    self.currentIndex = page;
//    NSLog(@"%ld",page);
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    SZYCalendarMonth *month = self.viewModel.allMonths[currentIndex];
    self.calendarTitle.titleLabel.text = [NSString stringWithFormat:@"%ld年 %ld月",month.year,month.month];
}

#pragma mark - SZYCalendarCellDelegate
- (void)calendarCell:(SZYCalendarCell *)cell selectCellModel:(SZYCalendarCellModel *)cellModel{
//    NSLog(@"年：%ld  月：%ld  日：%ld  星期：%ld",calendarDay.year,calendarDay.month,calendarDay.day,calendarDay.weekday);
    for (NSArray *tempArr in self.viewModel.allModels) {
        for (SZYCalendarCellModel *tempCellModel in tempArr) {
            if (tempCellModel == cellModel) {
                tempCellModel.select = YES;
            }else{
                tempCellModel.select = NO;
            }
        }
    }
    [self.collectionView reloadData];
    self.selectDay = cellModel.calendarDay;
    if ([self.delegate respondsToSelector:@selector(calendarView:selectCalendarDay:)]) {
        [self.delegate calendarView:self selectCalendarDay:cellModel.calendarDay];
    }
}
#pragma mark - SZYCalendarTitleDelegate
- (void)calendarTitle:(SZYCalendarTitle *)view clickType:(SZYCalendarClickType)clickType{
    
    NSInteger currentIndex = self.currentIndex;
    switch (clickType) {
        case SZYCalendarClickTypeUpYear:
            currentIndex -= 12;
            break;
        case SZYCalendarClickTypeUpMonth:
            currentIndex -= 1;
            break;
        case SZYCalendarClickTypeNextMonth:
            currentIndex += 1;
            break;
        case SZYCalendarClickTypeNextYear:
            currentIndex += 12;
            break;
        default:break;
    }
    if (currentIndex<0 || currentIndex >=self.viewModel.allModels.count) {
        return;
    }
    self.currentIndex = currentIndex;
    [self scrollToIndex:self.currentIndex];
}

- (void)scrollToIndex:(NSInteger)index{
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width * index, self.collectionView.contentOffset.y)];
}
@end
