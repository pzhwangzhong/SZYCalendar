//
//  CollectionViewCell.h
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZYCalendarCellModel.h"

@class SZYCalendarCell;
@protocol SZYCalendarCellDelegate <NSObject>

- (void)calendarCell:(SZYCalendarCell *)cell selectCellModel:(SZYCalendarCellModel *)cellModel;

@end
@interface SZYCalendarCell : UICollectionViewCell
@property (nonatomic,weak) id<SZYCalendarCellDelegate> delegate;
@property (nonatomic,strong) NSArray *cellModels;
@end
