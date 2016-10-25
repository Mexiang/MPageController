//
//  MSlidePageView.m
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "MSlidePageView.h"
#import "MSlidePageCell.h"

static NSString * cellID = @"MSlidePageView_CollectionView";

@interface MSlidePageView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong ,readwrite) NSArray *titlesArray;
@property (nonatomic, strong ) UICollectionView *collectionView;

@property (nonatomic, readwrite) NSIndexPath *selectIndexPath;

@end

@implementation MSlidePageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray
{
    if (self = [super initWithFrame:frame])
    {
        /*初始化默认数据*/
        self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        /*更新数据源*/
        self.titlesArray = titlesArray;
        
        /*创建collectionView*/
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0, self.frame.size.width-10,self.frame.size.height) collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView registerClass:[MSlidePageCell class] forCellWithReuseIdentifier:cellID];
        [self addSubview:_collectionView];
    }
    return self;
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSlidePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    
    [cell setTitle:self.titlesArray[indexPath.row] curentIndexPath:self.selectIndexPath];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectIndexPath == indexPath) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(mSlidePageView:didSelectItemAtIndexPath:itemTitle:)])
    {
        /*记录当前选中的index*/
        self.selectIndexPath = indexPath;
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.delegate mSlidePageView:self didSelectItemAtIndexPath:indexPath itemTitle:self.titlesArray[indexPath.row]];
        
        /*刷表*/
        [collectionView reloadData];
    }
}
/*设置每个cell的大小*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titlesArray[indexPath.row];
    return CGSizeMake(title.length*15+20, collectionView.frame.size.height);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

/*刷新数据源*/
- (void)reloadTitles:(NSArray *)titlesArray
{
    /*赋值新数据源*/
    self.titlesArray = titlesArray;
    
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    /*刷新界面*/
    if (_collectionView)
    {
        [_collectionView reloadData];
    }
}

/*切换当前显示的title*/
- (void)showVisibleTitle:(NSUInteger)index
{
    /*滑动至可视范围内*/
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    /*设置当前选中的cell*/
    self.selectIndexPath = [NSIndexPath indexPathForRow:index inSection:0];

    /*刷表*/
    if (_collectionView)
    {
        [_collectionView reloadData];
    }
}

- (void)dealloc
{
    
}

@end
