//
//  MPageController.m
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "MPageController.h"

static NSString *mCollectionCellID = @"MPageController_CollectionViewCell";

@interface MPageController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite) NSArray *classNames;
@property (nonatomic, strong) NSMutableArray *visibleControllers;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MPageController

- (instancetype)initWithControllersClassNames:(NSArray *)classNames
{
    if (self = [super init])
    {
        self.classNames = classNames;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*存放创建的UIViewController*/
    self.visibleControllers = [[NSMutableArray alloc]init];
    
    /*初始化collectionView*/
    [self initCollectionView];
}
#pragma mark -----------------------------------初始化-----------------------------------
- (void)initCollectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setMinimumLineSpacing:0];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);

        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setPagingEnabled:YES];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:mCollectionCellID];
        [self.view addSubview:_collectionView];
    }
}

#pragma mark -----------------------------------代理-----------------------------------
#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.classNames.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mCollectionCellID forIndexPath:indexPath];
    
    /*在cell上添加需要添加的controller*/
    //创建controller对象
    NSString *viewControllerName = self.classNames[indexPath.row];
    UIViewController *controller = [[NSClassFromString(viewControllerName) alloc]init];
    //将创建的对象放入数组中
    [self.visibleControllers addObject:controller];
    //将创建的controller添加在cell上
    controller.view.bounds = cell.contentView.bounds;
    [cell.contentView addSubview:controller.view];
    [self addChildViewController:controller];
    
    return cell;
}
#pragma mark UIScrollView delegate
/*开始滑动*/
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(mPageController:scrollViewWillBeginDragging:)])
    {
        [self.delegate mPageController:self scrollViewWillBeginDragging:scrollView];
    }
}
/*滑动中*/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(mPageController:scrollViewDidScroll:)])
    {
        [self.delegate mPageController:self scrollViewDidScroll:scrollView];
    }
}
/*滑动结束*/
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
    
    if ([self.delegate respondsToSelector:@selector(mPageController:scrollViewDidEndDecelerating:curentPage:)])
    {
        [self.delegate mPageController:self scrollViewDidEndDecelerating:scrollView curentPage:currentPage];
    }
}

#pragma mark ----------------------------------其他业务------------------------------------
/*显示MPageController*/
- (void)showWithSuperViewController:(UIViewController *)superViewController frame:(CGRect)frame
{
    CGRect newframe = frame;
    newframe.size.height = frame.size.height;
    newframe.size.width = frame.size.width;
    self.view.frame = newframe;
    
    [superViewController.view addSubview:self.view];
    [superViewController addChildViewController:self];
}
/*刷新数据源，刷新需要展示的界面*/
- (void)reloadWithControllersName:(NSArray *)classNames
{
    /*移除原有的数据源*/
    for (UIViewController *controller in self.visibleControllers)
    {
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    }
    [self.visibleControllers removeAllObjects];
    
    /*传入新的数据源*/
    self.classNames = classNames;
    
    /*刷新界面上需要显示的controller*/
    if (_collectionView)
    {
        [self.collectionView reloadData];
    }
}
/*切换到前要显示的视图控制器*/
- (void)showVisibleController:(NSUInteger)index
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

@end
