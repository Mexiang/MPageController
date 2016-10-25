//
//  ViewController.m
//  Collection
//
//  Created by Dry on 16/10/21.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "ViewController.h"
#import "MPageController.h"
#import "MSlidePageView.h"

@interface ViewController ()<MSlidePageViewDelegate,MPageControllerDelegate>

@property (nonatomic, strong) MSlidePageView *pageView;
@property (nonatomic, strong) MPageController *pageController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*初始化pageView*/
    [self initPagView];
    
    /*初始化pageController*/
    [self initPageController];
}

- (void)initPagView {
    if (!_pageView) {
        _pageView = [[MSlidePageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) titles:@[@"大连",@"青岛",@"济南",@"乌鲁木齐",@"北京",@"西安",@"石家庄",@"天津",@"重庆"]];
        [_pageView setDelegate:self];
        [self.view addSubview:_pageView];
    }
}
- (void)initPageController {
    if (!_pageController) {
        _pageController = [[MPageController alloc]initWithControllersClassNames:@[@"FirstViewController",@"SeconedViewController",@"OtherViewController",@"FirstViewController",@"SeconedViewController",@"OtherViewController",@"FirstViewController",@"SeconedViewController",@"OtherViewController"]];
        _pageController.delegate = self;
        [_pageController showWithSuperViewController:self frame:CGRectMake(0, _pageView.frame.origin.y+_pageView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*刷新MPageController*/
    [_pageView reloadTitles:@[@"推荐热点",@"热点历史",@"历史",@"社会"]];
    [_pageController reloadWithControllersName:@[@"OtherViewController",@"SeconedViewController",@"FirstViewController",@"OtherViewController"]];
}


#pragma mark MSlidePageViewDelegate
//选中pageView的某个cell的代理方法
- (void)mSlidePageView:(MSlidePageView *)pageView didSelectItemAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title {
    [_pageController showVisibleController:indexPath.row];
}

#pragma mark MPageController
//开发滑动代理
-(void)mPageController:(MPageController *)pageController scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

//滑动中代理
-(void)mPageController:(MPageController *)pageController scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

//滑动结束代理
-(void)mPageController:(MPageController *)pageController scrollViewDidEndDecelerating:(UIScrollView *)scrollView curentPage:(NSUInteger)curentPage {
    [_pageView showVisibleTitle:curentPage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
