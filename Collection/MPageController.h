//
//  MPageController.h
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPageController;
@protocol MPageControllerDelegate <NSObject>

@optional
/*
 开发滑动代理
 */
-(void)mPageController:(MPageController *)pageController scrollViewWillBeginDragging:(UIScrollView *)scrollView;

/*
 滑动中代理
 */
-(void)mPageController:(MPageController *)pageController scrollViewDidScroll:(UIScrollView *)scrollView;

/*
 滑动结束代理
 */
-(void)mPageController:(MPageController *)pageController scrollViewDidEndDecelerating:(UIScrollView *)scrollView curentPage:(NSUInteger)curentPage;

@end


@interface MPageController : UIViewController

/*
 当前MPageController上的viewController类名数组
 @[@"FirstViewController",@"SeconedViewController",@"OtherViewController"];
 */
@property (nonatomic, strong, readonly) NSArray *classNames;

/*
 代理
 */
@property (nonatomic, weak) id <MPageControllerDelegate>delegate;

/*
 init方法,传入要显示在MPageController上的controller类名数组,根据数组里的类名创建该显示的controller
 */
- (instancetype)initWithControllersClassNames:(NSArray *)classNames;

/*
 显示MPageController
 */
- (void)showWithSuperViewController:(UIViewController *)superViewController frame:(CGRect)frame;

/*
 传入新的数据源，传入需要显示的congtroller的类名数组，刷新需要展示的界面
 */
- (void)reloadWithControllersName:(NSArray *)classNames;

/*
 切换当前显示的界面,根据index切换到前要显示的视图控制器
 */
- (void)showVisibleController:(NSUInteger)index;

@end
