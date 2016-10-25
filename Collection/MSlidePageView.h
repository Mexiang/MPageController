//
//  MSlidePageView.h
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSlidePageView;
@protocol MSlidePageViewDelegate <NSObject>

@optional
/*
 选中某个cell的代理方法。
 */
- (void)mSlidePageView:(MSlidePageView *)pageView didSelectItemAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title;

@end


@interface MSlidePageView : UIView

/*
 MSlidePageView的title的数组，只读的。
 */
@property (nonatomic, strong ,readonly) NSArray *titlesArray;

/*
 代理
 */
@property (nonatomic, weak) id <MSlidePageViewDelegate>delegate;

/*
 当前选中的是第几页，默认是第一页,即selectIndexPath默认为row=0,section=0.
 */
@property (nonatomic, readonly) NSIndexPath *selectIndexPath;

/*
 初始化MSlidePageView对象的方法；传入frame定制MSlidePageView的frame；传入MSlidePageView上的title的数据源
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArray;

/*
 刷新MSlidePageView，刷新数量和title。
 */
- (void)reloadTitles:(NSArray *)titlesArray;

/*
 切换当前显示的title
 */
- (void)showVisibleTitle:(NSUInteger)index;

@end
