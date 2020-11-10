//
//  CommonPageViewController.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/10.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "CommonPageViewController.h"
#import "CommonTableViewController.h"

@interface CommonPageViewController ()<TFY_PageViewControllerDelegate,TFY_PageViewControllerDataSrouce>

@property (nonatomic, strong) TFY_PageViewController *pageViewController;

@end

@implementation CommonPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initPageViewController];
    
    [self configNavigationBarOfIndex:self.index];
}
- (UIColor *)colorOfR:(NSInteger)R G:(NSInteger)G B:(NSInteger)B {
    return [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1];
}
-(void)setIndex:(NSInteger)index{
    _index = index;
}
- (void)configNavigationBarOfIndex:(NSInteger)index {
    UIColor *tintColor = [UIColor blackColor];
    UIColor *titleColor = [UIColor blackColor];
    UIColor *backGroundColor = [UIColor whiteColor];
    UIImage *shadowImage = nil;
    switch (index) {
        case 0://今日头条
            tintColor = [UIColor whiteColor];
            titleColor = [UIColor whiteColor];
            backGroundColor = [self colorOfR:211 G:60 B:61];
            
            break;
        case 1://腾讯新闻
            backGroundColor = [UIColor whiteColor];
            break;
        case 2://澎湃新闻
            backGroundColor = [UIColor whiteColor];
            shadowImage = [[UIImage alloc] init];
            break;
        case 3://爱奇艺
            tintColor = [UIColor whiteColor];
            titleColor = [UIColor whiteColor];
            backGroundColor = [self colorOfR:48 G:48 B:50];
            
            break;
        case 4://优酷
            tintColor = [UIColor whiteColor];
            titleColor = [UIColor whiteColor];
            backGroundColor = [self colorOfR:33 G:33 B:33];
            break;
        case 5://腾讯视频
            backGroundColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    self.navigationController.tfy_titleColor = titleColor;
    self.navigationController.tfy_barBackgroundColor = backGroundColor;
}

- (void)initPageViewController {
    self.pageViewController = [[TFY_PageViewController alloc] initWithConfig:self.config];
    self.pageViewController.view.frame = self.view.bounds;
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    if (self.index==18) {
        self.pageViewController.rightView = [self rightView];
    }
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (UIViewController *)pageViewController:(TFY_PageViewController *)pageViewController viewControllerForIndex:(NSInteger)index {
    CommonTableViewController *vc = [[CommonTableViewController alloc] init];
    return vc;
}

- (NSString *)pageViewController:(TFY_PageViewController *)pageViewController titleForIndex:(NSInteger)index {
    return self.titles[index];
}

- (NSInteger)pageViewControllerNumberOfPage {
    return self.titles.count;
}

- (void)pageViewController:(TFY_PageViewController *)pageViewController didSelectedAtIndex:(NSInteger)index {
    NSLog(@"切换到了：%@",self.titles[index]);
}

-(UIView *)rightView{
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, TFY_kNavBarHeight())];
    views.backgroundColor = UIColor.redColor;
    return views;
}
@end
