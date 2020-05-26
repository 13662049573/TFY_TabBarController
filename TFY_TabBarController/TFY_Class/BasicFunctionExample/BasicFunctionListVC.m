//
//  BasicFunctionListVC.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/10.
//  Copyright © 2019 xianliang meng. All rights reserved.
//

#import "BasicFunctionListVC.h"
#import "CommonPageViewController.h"

@interface BasicFunctionListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BasicFunctionListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分页展示";
    self.navigationController.tfy_barBackgroundColor = [UIColor blueColor];
    self.navigationController.tfy_titleColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildTable];
}

- (void)buildTable {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self cellTitles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd、%@",indexPath.row + 1,[self cellTitles][indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommonPageViewController *exampleVC = [[CommonPageViewController alloc] init];
    exampleVC.title = [self cellTitles][indexPath.row];
    exampleVC.config = [self configOfIndexPath:indexPath];
    exampleVC.titles = [self vcTitlesOfIndexPath:indexPath];
    exampleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:exampleVC animated:true];
    
    
}

- (NSArray *)cellTitles {
    return @[
             @"基本样式-标题正常显示（默认）",
             @"基本样式-标题显示在导航栏上",
             @"Segmented样式-标题正常显示",
             @"Segmented样式-标题显示在导航栏上",
             @"标题栏-局左",
             @"标题栏-局中",
             @"标题栏-局右",
             @"标题-自定义宽度",
             @"标题-自定义高度",
             @"标题-文字局上",
             @"标题-文字居下",
             @"标题-关闭标题颜色过渡",
             @"阴影动画-缩放",
             @"阴影动画-无",
             @"阴影末端形状-圆角",
             @"阴影末端形状-直角",
             @"阴影-居上",
             @"阴影-居中",
             ];
}

- (TFY_PageControllerConfig *)configOfIndexPath:(NSIndexPath *)indexPath {
    TFY_PageControllerConfig *config = [TFY_PageControllerConfig defaultConfig];
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            //在导航栏中显示标题
            config.showTitleInNavigationBar = true;
            //隐藏底部分割线
            config.separatorLineHidden = true;
            break;
        case 2:
            //设置标题样式为分段
            config.titleViewStyle = TFY_PageTitleViewStyleSegmented;
            //分段选择器颜色
            config.segmentedTintColor = [UIColor blackColor];
            //标题缩进
            config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
            break;
        case 3:
            //设置标题样式为分段
            config.titleViewStyle = TFY_PageTitleViewStyleSegmented;
            //分段选择器颜色
            config.segmentedTintColor = [UIColor blackColor];
            //标题缩进
            config.titleViewInset = UIEdgeInsetsMake(5, 50, 5, 50);
            //在navigationBar上显示标题
            config.showTitleInNavigationBar = true;
            //隐藏底部分割线
            config.separatorLineHidden = true;
            break;
        case 4:
            //标题左对齐
            config.titleViewAlignment = TFY_PageTitleViewAlignmentLeft;
            break;
        case 5:
            //标题居中显示
            config.titleViewAlignment = TFY_PageTitleViewAlignmentCenter;
            break;
        case 6:
            //标题右对齐
            config.titleViewAlignment = TFY_PageTitleViewAlignmentRight;
            break;
        case 7:
            //设置标题宽度为屏幕宽度1/3
            config.titleWidth = self.view.bounds.size.width/3.0f;
            //设置标题间隔为0
            config.titleSpace = 0;
            //设置标题缩进
            config.titleViewInset = UIEdgeInsetsZero;
            break;
        case 8:
            //设置标题高度
            config.titleViewHeight = 64;
            break;
        case 9:
            //标题文字上对齐
            config.textVerticalAlignment = TFY_PageTextVerticalAlignmentTop;
            break;
        case 10:
            //标题缩进
            config.titleViewInset = UIEdgeInsetsMake(0, 10, 5, 10);
            //标题文字下对齐
            config.textVerticalAlignment = TFY_PageTextVerticalAlignmentBottom;
            break;
        case 11:
            //标题颜色过渡
            config.titleColorTransition = false;
            break;
        case 12:
            //设置阴影动画为缩放
            config.shadowLineAnimationType = TFY_PageShadowLineAnimationTypeZoom;
            break;
        case 13:
            //设置阴影动画为无动画
            config.shadowLineAnimationType = TFY_PageShadowLineAnimationTypeNone;
            break;
        case 14:
            //设置阴影末端形状为圆角
            config.shadowLineCap = TFY_PageShadowLineCapRound;
            config.shadowLineHeight = 5;
            break;
        case 15:
            //设置阴影末端形状为直角
            config.shadowLineCap = TFY_PageShadowLineCapSquare;
            config.shadowLineHeight = 5;
            break;
        case 16:
            //阴影上对齐
            config.shadowLineAlignment = TFY_PageShadowLineAlignmentTop;
            break;
        case 17:
            //阴影居中
            config.shadowLineAlignment = TFY_PageShadowLineAlignmentCenter;
            break;

        default:
            break;
    }
    return config;
}

- (NSArray *)vcTitlesOfIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArr = @[@"关注",@"推荐",@"热点",@"问答",@"科技",@"国风",@"直播",@"新时代",@"北京",@"国际",@"数码",@"小说",@"军事"];
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 ||indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) {
        titleArr = @[@"关注",@"推荐",@"热点"];
    }
    return titleArr;
}

@end
