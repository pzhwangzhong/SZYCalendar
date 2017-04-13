//
//  SZYCalendarTitle.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "SZYCalendarTitle.h"
@interface SZYCalendarTitle()
@property (nonatomic,strong) NSArray *titles;

@end
@implementation SZYCalendarTitle

- (NSArray *)titles{
    if (_titles==nil) {
        _titles = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _titles;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 80;
        CGFloat titleH = 40;
        CGFloat weekH = height - titleH;
        
        // 添加按钮
        CGFloat btnH = titleH;
        CGFloat btnW = titleH * 1.2;
        [self creatBtnWithFrame:CGRectMake(0, 0, btnW, btnH) title:@"上一年" color:[UIColor blueColor] tag:100];
        
        [self creatBtnWithFrame:CGRectMake(btnW, 0, btnW, btnH) title:@"上一月" color:[UIColor purpleColor] tag:101];
        
        [self creatBtnWithFrame:CGRectMake(width - btnW, 0,btnW, btnH) title:@"下一年" color:[UIColor blueColor] tag:102];
        
        [self creatBtnWithFrame:CGRectMake(width - btnW * 2, 0, btnW, btnH) title:@"下一月" color:[UIColor purpleColor] tag:103];
        
        // 添加标题
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(btnW * 2,0 , width - btnW  * 4, titleH)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        _titleLabel.text = @"2017年 5月";
        _titleLabel.backgroundColor = [UIColor yellowColor];
        
        //添加星期
        CGFloat labelW = frame.size.width / self.titles.count;
        CGFloat labelH = weekH;
        CGFloat currentX = 0;
        for (int i = 0; i < self.titles.count; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(currentX, btnH, labelW, labelH)];
            label.text = self.titles[i];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            currentX += labelW;
        }
    }
    return self;
}

- (void)creatBtnWithFrame:(CGRect)frame
                          title:(NSString *)title
                          color:(UIColor *)color
                            tag:(NSInteger)tag
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = color;
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:btn];
}
- (void)btnClicked:(UIButton *)sender{
    SZYCalendarClickType type;
    switch (sender.tag) {
        case 100:// 上一年
            type = SZYCalendarClickTypeUpYear;
            break;
        case 101:// 上一月
            type = SZYCalendarClickTypeUpMonth;
            break;
        case 102:// 下一年
            type = SZYCalendarClickTypeNextYear;
            break;
        case 103:// 下一月
            type = SZYCalendarClickTypeNextMonth;
            break;
        default:
            type = 0;
            break;
    }
    if ([self.delegate respondsToSelector:@selector(calendarTitle:clickType:)]) {
        [self.delegate calendarTitle:self clickType:type];
    }
}

@end
