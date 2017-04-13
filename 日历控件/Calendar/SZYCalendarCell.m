//
//  CollectionViewCell.m
//  日历控件
//
//  Created by 王中 on 2017/4/11.
//  Copyright © 2017年 王中. All rights reserved.
//

#import "SZYCalendarCell.h"
@interface SZYCalendarCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@end
static NSString *const cellId = @"cellIdxxx";

NSInteger maxRow = 6;
NSInteger maxCol = 7;
CGFloat margin = 5;
@implementation SZYCalendarCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        CGFloat itemW = (width - margin * (maxCol + 1)) / maxCol;
        CGFloat itemH = (height - margin * (maxRow + 1)) / maxRow;
        
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = margin;//列间距
        layout.minimumLineSpacing = margin;//行间距
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;//水平滚动
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_collectionView];
        
        //注册
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setCellModels:(NSArray *)cellModels{
    _cellModels = cellModels;
    [self.collectionView reloadData];
}
#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    SZYCalendarCellModel *cellModel = self.cellModels[indexPath.row];
    UILabel *label = [cell viewWithTag:200];
    if (!label) {
        label = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 200;
        [cell addSubview:label];
    }
    
    label.text = cellModel.title;
    if (cellModel.title) {
        if (cellModel.select) {
            cell.backgroundColor = [UIColor redColor];
        }else{
            cell.backgroundColor = [UIColor purpleColor];
        }
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被点击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    SZYCalendarCellModel *cellModel = self.cellModels[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(calendarCell:selectCellModel:)]) {
        [self.delegate calendarCell:self selectCellModel:cellModel];
    }
}


@end
